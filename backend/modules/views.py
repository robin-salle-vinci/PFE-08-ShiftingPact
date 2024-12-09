import uuid

from django.http import JsonResponse, HttpResponse
from django.views.decorators.http import require_GET, require_POST, require_http_methods
import json
from modules.models import Answers
from backend.utils.json_utils import module_json, module_single_json
from backend.utils.token_utils import  check_authenticated_user
from modules.models import ModulesESG
from users.models import Users
from questions.models import Choices
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

        if state_value not in ['validated', 'verified']:
            return JsonResponse({'error': 'Invalid state value'}, status=400)
        else:
            modules = ModulesESG.filter_by_state(state_value)

        modules_json = [module_single_json(module) for module in modules]
        return JsonResponse(modules_json, safe=False, status=200)
    except Exception as e:
            print(str(e))
            return JsonResponse({'error': str(e)}, status=500)


# Get one ESG module by esg id(for employees only)
@require_GET
def read_module_by_esg_id(request, uuid_module_esg):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user
        
        if authenticated_user.role != 'employee':
            return JsonResponse({'error': 'Only employees can access this endpoint'}, status=403)

        module = ModulesESG.objects(id=uuid_module_esg).first()
        if not module:
            return JsonResponse({'error': 'Module not found'}, status=404)
        
        return JsonResponse(module_json(module), status=200)
    
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

# Get one ESG module by client id(for employees and client)
@require_GET
def read_module_by_client_id(request, uuid_client):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user

        if not (authenticated_user.role == 'employee' or str(authenticated_user.id) == str(uuid_client)):
            return JsonResponse({'error': 'Only the author can acces to there esg'}, status=403)

        module = ModulesESG.objects(id_client=uuid_client).filter(state='open').first() # est ce que un client a voir son module dans n'importe quelle etat

        if not module:
            return JsonResponse({'error': 'Module not found'}, status=404)

        return JsonResponse(module_json(module), status=200)
    
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)



@require_POST
def create_esg_views(request):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user
        
        if authenticated_user.role != 'employee':
            return JsonResponse({'error': 'Only employee can access this endpoint'}, status=403)

        data = json.loads(request.body)
        id_client = data.get('idClient')

        # check if client exist
        if not id_client:
            return JsonResponse({'message': 'Client id is required'}, status=400)
        if Users.objects.filter(id=id_client).count() == 0:
            return JsonResponse({'message': 'Client does not exist'}, status=400)
            
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
def change_state_esg(request, uuid_module_esg):
    # authentication part
    authenticated_user = check_authenticated_user(request)
    if isinstance(authenticated_user, HttpResponse):
        return authenticated_user

    # check query param new_state
    new_state = request.GET.get('newState', None)
    if new_state is None:
        return HttpResponse("No new state provided", status=400)
    if new_state not in ['validated', 'verified']:
        return HttpResponse("Invalid new state, must be validated or verified", status=400)

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
    if current_state == 'open' and new_state != 'validated' or current_state == 'validated' and new_state != 'verified' or current_state == 'verified':
        return HttpResponse("consistency must be open -> validated -> verified", status=400)
    if user_role == 'employee' and new_state != 'verified' or user_role == 'client' and new_state != 'validated':
        return HttpResponse("An employee can only verify and a client can only validate an ESG module", status=403)

    ModulesESG.objects(id=uuid_module_esg).update(state=new_state)
    return HttpResponse("Successful modification")



@require_http_methods(["PATCH"])
def answer_question(request):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user
        
        if authenticated_user.role != 'employee':
            return JsonResponse({'error': 'Only employees can access this endpoint'}, status=403)

        data = json.loads(request.body)
        id_esg = data.get('id_esg')
        id_answere = data.get('id_answere')
        id_choice = data.get('id_choice')
        value = data.get('value')
        is_commitment = data.get('is_commitment')

        if not id_esg or not id_answere or not value or is_commitment is None:
            return JsonResponse({'error': 'id_esg, id_answere, value, is_commitment fields are required'}, status=400)

        module = ModulesESG.objects.get(pk=id_esg)

       

        # if old_answere.value == value and old_answere.is_commitment == is_commitment and old_answere.id_choice == id_choice:
        #     return JsonResponse({'message': 'No modification'}, status=400)



        ## Already modify
        if id_answere in module.modified_answers:
            Answers.objects(id=id_answere).update(value=value, is_commitment=is_commitment,  id_choice=id_choice, score_response=new_choice.score if new_choice else 0)

        ## Not modify
        else:

            old_answere =  Answers.objects.get(pk=id_answere)

            if not old_answere:
                return JsonResponse({'error': 'Answer not found'}, status=404)
            
            if id_choice is not None:
                new_choice = Choices.objects.get(pk=id_choice)
                if old_answere.id_choice == id_choice:
                    return JsonResponse({'message': 'Answer already has this choice'}, status=400)


            # convertor is_commitment to boolean
            is_commitment = True if is_commitment == 'true' else False
            
            modified_answer = Answers.objects.create(
                id_challenge=old_answere.id_challenge,
                id_sub_challenge=old_answere.id_sub_challenge,
                id_question=old_answere.id_question,
                id_choice=id_choice,
                value=value,
                commentary=old_answere.commentary,
                is_commitment=is_commitment,
                score_response=new_choice.score if new_choice else 0
            )
            list_modified_answers = module.modified_answers
            list_modified_answers.append(modified_answer.id)
            module.update(modified_answers=list_modified_answers)   

        
        return JsonResponse({'message': 'Answer modify successfully'}, status=200)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
    
