from django.http import JsonResponse, HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_GET, require_POST, require_http_methods
import json
from backend.utils.utils import module_json, check_authenticated_user
from modules.models import ModulesESG
from users.models import Users
from datetime import datetime



@require_GET
def read_modules(request):
    try:

        user = check_authenticated_user(request)

        if isinstance(user, JsonResponse):
            return user

        if user.role != 'employee':
            return JsonResponse({'Not Allowed'}, status=403)

        state_value = request.GET.get('state')


        if state_value is None:
            modules = ModulesESG.get_all()
        if state_value not in ['open', 'validated', 'verified']:
            modules = ModulesESG.filter_by_state(state_value)
        else:
            return JsonResponse({'error': 'Invalid state value'}, status=400)


        modules_data = [
            module_json(module)
            for module in modules
        ]

        return JsonResponse(modules_data, safe=False ,status=200)

    except Exception as e:
        print(str(e))
        return JsonResponse({'error': str(e)}, status=500)


@require_POST
def create_esg_views(request):
    try:
        # Check if auth && is an employee
        # header = request.headers.get('Authorization')
        # if not header or not header.startswith('Bearer '):
        #     return JsonResponse({'error': 'Invalid Authorization header'}, status=400)

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

@csrf_exempt
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
