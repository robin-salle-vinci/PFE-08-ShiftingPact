import uuid
from django.http import JsonResponse, HttpResponse
from django.views.decorators.http import require_GET, require_POST, require_http_methods
import json

from commitments.models import CommitmentPacts
from modules.models import Answers
from backend.utils.json_utils import module_json, module_single_json, answer_json
from backend.utils.token_utils import check_authenticated_user
from modules.models import ModulesESG
from questions.scoring_algo import calculate_sub_challenge_scores, \
    calculate_theme_scores, \
    calculate_global_esg_scores, calculate_challenge_scores
from users.models import Users
from questions.models import Choices, Questions
from datetime import datetime


# Get all ESG modules (for employees only)
@require_GET
def read_modules(request):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user

        if authenticated_user.role != 'employee':
            return JsonResponse({'error': 'Only employees can access this endpoint'}, status=403)

        state_value = request.GET.get('state')

        if state_value not in ['validated', 'verification']:
            return JsonResponse({'error': 'Invalid state value'}, status=400)
        else:
            modules = ModulesESG.filter_by_state(state_value)

        modules_json = [module_single_json(module) for module in modules]
        return JsonResponse(modules_json, safe=False, status=200)
    except Exception as e:
        print(str(e))
        return JsonResponse({'error': str(e)}, status=500)


# @require_GET
# def read_modules_by_client_id(request, uuid_client):
#     try:
#         authenticated_user = check_authenticated_user(request)
#         if isinstance(authenticated_user, HttpResponse):
#             return authenticated_user

#         modules = ModulesESG.objects.all().filter(client_id=uuid_client)

#         if authenticated_user.role != 'employee':
#             return JsonResponse({'error': 'Only the author can acces to there esg'}, status=403)

#         data_json = [module_single_json(module) for module in modules]

#         return JsonResponse(data_json, status=200)

#     except Exception as e:
#         return JsonResponse({'error': str(e)}, status=500)


# Get one ESG module by esg id(for employees only)
@require_GET
def read_module_by_esg_id(request, uuid_module_esg):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user

        module_esg = ModulesESG.objects.get(id=uuid_module_esg)

        if not (authenticated_user.role == 'employee' or authenticated_user.id == module_esg.id_client):
            return JsonResponse({'error': 'Only employees can access this endpoint'}, status=403)

        module = ModulesESG.objects(id=uuid_module_esg).first()
        if not module:
            return JsonResponse({'error': 'Module not found'}, status=404)

        return JsonResponse(module_json(module), status=200)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


# Get one ESG module by client id(for employees and clients)
@require_GET
def read_module_by_client_id(request, uuid_client):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user

        module = ModulesESG.objects(id_client=uuid_client).filter(state='open').first()

        if not module:
            return JsonResponse({'error': 'Module not found'}, status=404)

        if not (authenticated_user.role == 'employee' or str(authenticated_user.id) == str(uuid_client)):
            return JsonResponse({'error': 'Only the author can acces to there esg'}, status=403)
        

        return JsonResponse(module_json(module), status=200)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


@require_POST
def create_esg_views(request, uuid_client):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user

        if authenticated_user.role != 'employee':
            return JsonResponse({'error': 'Only employee can access this endpoint'}, status=403)

        # check if client exist
        if Users.objects.filter(id=uuid_client).count() == 0:
            return JsonResponse({'message': 'Client does not exist'}, status=404)

        ModulesESG.objects.create(
            id_client=uuid_client,
            date_last_modification=datetime.today().date(),
            original_answers=[],
            modified_answers=[],
            state="open",
        )
        return JsonResponse({'message': 'Module ESG created successfully'}, status=201)

    except Exception as e:
        return JsonResponse({'message': str(e)}, status=500)


# Create your views here.
@require_http_methods(["PATCH"])
def change_state_esg(request, uuid_module_esg):
    # authentication part
    authenticated_user = check_authenticated_user(request)
    if isinstance(authenticated_user, HttpResponse):
        return authenticated_user

    # check query param new_state
    new_state = request.GET.get('newState', None)
    if new_state is None:
        return HttpResponse("No new state provided", status=400)
    if new_state not in ['verification', 'validated']:
        return HttpResponse("Invalid new state, must be verification or validated", status=400)

    # check module esg
    module_esg = ModulesESG.objects(id=uuid_module_esg).first()
    if not module_esg:
        return HttpResponse("Module ESG not found", status=404)
    if authenticated_user.role != 'employee' and module_esg.id_client != authenticated_user.id:
        return HttpResponse("It's not a module ESG of the authenticated client", status=403)

    # check consistency of the state
    current_state = module_esg.state
    user_role = authenticated_user.role
    if current_state == new_state: return HttpResponse("New state must be different than current state", status=400)
    if current_state == 'open' and new_state != 'verification' or current_state == 'verification' and new_state != 'validated' or current_state == 'validated':
        return HttpResponse("consistency must be open -> verification -> validated", status=400)
    if user_role == 'employee' and new_state != 'validated' or user_role == 'client' and new_state != 'verification':
        return HttpResponse("An employee can only validate and a client can only set to verification an ESG module",
                            status=403)

    if new_state == 'validated':
        print(module_esg.original_answers)
        # Récupérer toutes les réponses originales et modifiées pour le pacte d'engagement
        original_answers = Answers.objects.filter(id__in=module_esg.original_answers, is_commitment=True)
        modified_answers = Answers.objects.filter(id__in=module_esg.modified_answers, is_commitment=True)

        # Créer un dictionnaire basé sur id_question pour permettre un écrasement des réponses originales
        answers_dict = {answer.id_question: answer for answer in original_answers}

        # Remplacer ou ajouter les réponses modifiées
        for answer in modified_answers:
            answers_dict[answer.id_question] = answer

        # Obtenir la liste des réponses finales
        answers_to_commitment = [answer.id for answer in answers_dict.values()]

        # Créer le pacte d'engagement
        CommitmentPacts.objects.create(
            id_client=module_esg.id_client,
            creation_date=datetime.today().date(),
            answers_commitments=answers_to_commitment
        )

    ModulesESG.objects(id=uuid_module_esg).update(state=new_state)
    return HttpResponse("Successful modification of state", status=201)


# Add or modify an answer in a module ESG - Employee only
@require_http_methods(["PATCH"])
def add_modified_answers(request):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user

        if authenticated_user.role != 'employee':
            return JsonResponse({'error': 'Only employees can access this endpoint'}, status=403)

        data = json.loads(request.body)
        id_esg = data.get('id_esg')
        id_challenge = data.get('id_challenge')
        id_sub_challenge = data.get('id_sub_challenge')
        commentary = data.get('commentary')
        id_question = data.get('id_question')
        id_choice = data.get('id_choice')
        value = data.get('value')
        is_commitment = data.get('is_commitment')
        
        if id_esg is None or id_question is None or value is None or is_commitment is None :
            return JsonResponse({'error': 'id_esg, id_question, value, is_commitment fields are required'}, status=400)

        module_esg = ModulesESG.objects.get(pk=id_esg)

        if not module_esg:
            return JsonResponse({'error': 'Module ESG not found'}, status=404)
        
        if not module_esg.state == 'verified':
            return JsonResponse({'error': 'Module ESG is not in verified'}, status=400)

        new_choice = Choices.objects.get(pk=id_choice)
        score = 0 if not new_choice else new_choice.score

        answer = Answers.objects(id_question=id_question, id__in=module_esg.modified_answers).first()
        if answer:

            answer.update(value=value, is_commitment=is_commitment, id_choice=id_choice,
                                                 score_response=score, commentary=commentary)
        else:
            print("create answer")
            new_answer = Answers.objects.create(
                id_challenge=id_challenge,
                id_sub_challenge=id_sub_challenge,
                id_question=id_question,
                id_choice=id_choice,
                value=value,
                commentary=commentary,
                is_commitment=is_commitment,
                score_response=score,
            )

            list_modified_answers = module_esg.modified_answers
            list_modified_answers.append(new_answer.id)
            module_esg.update(modified_answers=list_modified_answers)

        return JsonResponse({'message': 'Answer modify successfully'}, status=200)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


# Add or modify an answer in a module ESG - Client only
@require_http_methods(["PATCH"])
def add_original_answers(request, uuid_module_esg):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user

        if authenticated_user.role != 'client':
            return JsonResponse({'message': 'Not Authorized'}, status=403)

        data = json.loads(request.body)
        id_challenge = data.get('id_challenge')
        id_sub_challenge = data.get('id_sub_challenge')
        commentary = data.get('commentary')
        id_question = data.get('id_question')
        id_choice = data.get('id_choice')
        value = data.get('value')
        is_commitment = data.get('is_commitment')

        if not (uuid_module_esg or id_question or value or is_commitment or id_choice) is None:
            return JsonResponse({'error': 'id_esg, id_question, value, is_commitment fields are required'}, status=400)

        module_esg = ModulesESG.objects.get(pk=uuid_module_esg)

        if not module_esg:
            return JsonResponse({'error': 'Module ESG not found'}, status=404)

        if module_esg.id_client != authenticated_user.id:
            return JsonResponse({'message': 'Not Authorized'}, status=403)

        if module_esg.state != 'open':
            return JsonResponse({'message': 'Not Authorized'}, status=403)

        new_choice = Choices.objects.get(pk=id_choice)
        score = 0 if not new_choice else new_choice.score

        answer = Answers.objects(id_question=id_question, id__in=module_esg.original_answers).first()

        if answer:
            answer.update(value=value, is_commitment=is_commitment, id_choice=id_choice,
                                                 score_response=score, commentary=commentary)
        else:
            new_answer = Answers.objects.create(
                id_challenge=id_challenge,
                id_sub_challenge=id_sub_challenge,
                id_question=id_question,
                id_choice=id_choice,
                value=value,
                commentary=commentary,
                is_commitment=is_commitment,
                score_response=score,
            )

            list_original_answers = module_esg.original_answers
            list_original_answers.append(new_answer.id)
            module_esg.update(original_answers=list_original_answers)

        return JsonResponse({'message': 'Answer modify successfully'}, status=200)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


def stringify_keys(data):
    """
    Recursively convert all dictionary keys to strings.
    """
    if isinstance(data, dict):
        return {str(key): stringify_keys(value) for key, value in data.items()}
    elif isinstance(data, list):
        return [stringify_keys(item) for item in data]
    return data

@require_http_methods(["PATCH"])
def add_score (request, uuid_module_esg) :
    # check authentication
    authenticated_user = check_authenticated_user(request)
    if isinstance(authenticated_user, HttpResponse):
        return authenticated_user

    # check if the user is an employee
    if authenticated_user.role != 'employee':
        return JsonResponse({'error': 'Only employees can access this endpoint'}, status=403)

    try:
        module_esg = ModulesESG.get_by_id(uuid_module_esg)
    except ModulesESG.DoesNotExist:
        return JsonResponse({'error': 'Module ESG not found'}, status=404)

    # Check module state
    if module_esg.state == 'open':
        return JsonResponse(
            {'error': 'Module ESG must be in verification or validated state'},
            status=400)

    # Calculate ESG scores
    try:
        sub_challenge_scores = calculate_sub_challenge_scores(module_esg)
        challenge_scores = calculate_challenge_scores(sub_challenge_scores)
        theme_scores = calculate_theme_scores(challenge_scores)
        global_esg_scores = calculate_global_esg_scores(theme_scores)
    except Exception as e:
        return JsonResponse({'error': f'Error calculating ESG score: {str(e)}'},
                            status=500)

    try:
        module_esg.update(calculated_score=global_esg_scores['total_esg_score'])
        module_esg.save()
    except Exception as e:
        return JsonResponse({'error': f'Error saving ESG score: {str(e)}'},
                            status=500)

    # Combine results into a single object with stringified keys
    combined_scores = stringify_keys({
        "sub_challenge_scores": sub_challenge_scores,
        "challenge_scores": challenge_scores,
        "theme_scores": theme_scores,
        "global_esg_scores": global_esg_scores
    })


    return JsonResponse(combined_scores, status=200)
