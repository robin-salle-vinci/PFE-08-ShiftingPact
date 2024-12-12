import json
from datetime import datetime

from django.http import JsonResponse, HttpResponse
from django.views.decorators.http import require_GET, require_POST, require_http_methods

from backend.utils.json_utils import module_json, module_single_json
from backend.utils.token_utils import check_authenticated_user
from commitments.models import CommitmentPacts
from modules.models import Answers
from modules.models import ModulesESG
from questions.models import Choices, Questions
from questions.scoring_algo import calculate_global_esg_scores
from users.models import Users, ClientInformation


# Get all ESG modules
@require_GET
def read_all(request):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user

        if authenticated_user.role == 'employee':
            modules = ModulesESG.objects.all()
        else:
            modules = ModulesESG.objects.all().filter(id_client=authenticated_user.id)

        modules_json = [module_single_json(module) for module in modules]

        return JsonResponse(modules_json, safe=False, status=200)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


# Get one ESG Module by id
@require_GET
def read_one_by_id(request, uuid_esg_module):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user

        module = ModulesESG.objects(id=uuid_esg_module).first()
        if not module:
            return JsonResponse({'error': 'Module not found'}, status=404)

        if authenticated_user.role != 'employee' or (
                authenticated_user.id != module.id_client and authenticated_user.role == 'client'):
            return JsonResponse({'error': 'Only employees can access this endpoint or the correct client'}, status=403)

        return JsonResponse(module_json(module), status=200)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


# Get one ESG module (last client module)
@require_GET
def read_last_module_for_client(request):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user

        if authenticated_user.role == 'employee':
            return JsonResponse({'error': 'Only the author can access to there esg'}, status=403)

        module = ModulesESG.objects(id_client=authenticated_user.id).filter(state='open').first()

        if not module:
            return JsonResponse({'error': 'Module not found'}, status=404)

        if str(module.id_client) != str(authenticated_user.id):
            return JsonResponse({'error': 'Only the author can access to there esg'}, status=403)

        return JsonResponse(module_json(module), status=200)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


@require_POST
def create_one(request):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user

        if authenticated_user.role != 'employee':
            return JsonResponse({'error': 'Only employee can access this endpoint'}, status=403)

        request_body = json.loads(request.body)
        id_client = request_body.get('id_client')

        if id_client is None:
            return JsonResponse({'error': 'id_client field is required'}, status=400)

        # check if client exist
        if Users.objects.filter(id=id_client).count() == 0:
            return JsonResponse({'message': 'Client does not exist'}, status=404)

        ModulesESG.objects.create(
            id_client=id_client,
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
def change_state(request, uuid_module_esg):
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

    # check if the client had answer to all questions
    if new_state == 'verification':
        client_infos = ClientInformation.objects(id_user=authenticated_user.id).first()
        filters_template = ['ALL']
        if client_infos.number_workers > 0: filters_template.append('WORKERS')
        if client_infos.owned_facility: filters_template.append('OWNED FACILITY')
        if client_infos.service_or_product == 'product': filters_template.append('PRODUITS')
        questions_to_answer = Questions.objects.filter(template__in=filters_template).all()
        if len(module_esg.original_answers) != questions_to_answer.count():
            return HttpResponse("The client has not answered all questions", status=400)
        #calculate ESG score

    # créer pacte d'engagement si validated
    if new_state == 'validated':
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
            answers_commitments=answers_to_commitment,
            id_module_esg=module_esg.id,
        )
        global_esg_scores = calculate_global_esg_scores(module_esg)
        module_esg.update(calculated_score=global_esg_scores['total_percentage'])
        module_esg.save()

    ModulesESG.objects(id=uuid_module_esg).update(state=new_state)
    return HttpResponse("Successful modification of state", status=201)


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

        if uuid_module_esg is None or id_question is None or value is None or is_commitment is None:
            return JsonResponse({'error': 'id_esg, id_question, value, is_commitment fields are required'}, status=400)

        module_esg = ModulesESG.objects.get(pk=uuid_module_esg)

        if not module_esg:
            return JsonResponse({'error': 'Module ESG not found'}, status=404)

        if module_esg.id_client != authenticated_user.id:
            return JsonResponse({'message': 'Not Authorized'}, status=403)

        if module_esg.state != 'open':
            return JsonResponse({'message': 'Not Authorized'}, status=403)

        if id_choice is not None:
            new_choice = Choices.objects.get(pk=id_choice)
            score = new_choice.score
        else:
            new_choice = None
            score = 0

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
            module_esg.update(date_last_modification=datetime.today().date())

        return JsonResponse({'message': 'Answer modify successfully'}, status=200)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


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

        if id_esg is None or id_question is None or value is None or is_commitment is None:
            return JsonResponse({'error': 'id_esg, id_question, value, is_commitment fields are required'}, status=409)

        module_esg = ModulesESG.objects.get(pk=id_esg)

        if not module_esg:
            return JsonResponse({'error': 'Module ESG not found'}, status=404)

        if id_choice is not None:
            new_choice = Choices.objects.get(pk=id_choice)
            score = new_choice.score
        else:
            new_choice = None
            score = 0

        answer = Answers.objects(id_question=id_question, id__in=module_esg.modified_answers).first()

        if answer:
            answer.update(value=value, is_commitment=is_commitment, id_choice=id_choice, score_response=score,
                          commentary=commentary)
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
            module_esg.update(date_last_modification=datetime.today().date())

        #calculate ESG score
        global_esg_scores = calculate_global_esg_scores(module_esg)
        module_esg.update(calculated_score=global_esg_scores['total_percentage'])
        module_esg.save()

        return JsonResponse({'message': 'Answer modify successfully'}, status=200)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@require_GET
def get_score(request, uuid_module_esg):
    authenticated_user = check_authenticated_user(request)
    if isinstance(authenticated_user, HttpResponse):
        return authenticated_user

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
        global_esg_scores = calculate_global_esg_scores(module_esg)
    except Exception as e:
        return JsonResponse({'error': f'Error calculating ESG score: {str(e)}'},
                            status=500)

    return JsonResponse(global_esg_scores, status=200)
