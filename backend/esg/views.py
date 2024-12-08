
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render
from django.views.decorators.http import require_POST
from users.models import  Users
from esg.models import ModulesESG
from datetime import datetime

from users.utils.token_utils import check_authenticated_user


# Create your views here.

def change_state_esg(request, uuid_module_esg):
    # authentication part
    authenticated_user = check_authenticated_user(request)
    if isinstance(authenticated_user, JsonResponse):
        return authenticated_user

    # check query param new_state
    new_state = request.GET.get('new_state', None)
    if new_state is None:
        return HttpResponse("No new state provided", status=400)
    if new_state not in ['validated', 'verified']:
        return HttpResponse("Invalid new state, must be validated or verified", status=400)

    # check module esg
    module_esg = ModulesESG.objects(id=uuid_module_esg)
    if not module_esg:
        return HttpResponse("Module ESG not found", status=404)
    if authenticated_user.role != 'employee' and module_esg.id_client != authenticated_user.id:
        return HttpResponse("It's not a module ESG of the authenticated client", status=403)

    # check consistency of the request
    current_state = module_esg.state
    user_role = authenticated_user.role
    if current_state == 'open' and new_state != 'validated' or current_state == 'validated' and new_state != 'verified':
        return JsonResponse({'error': 'consistency must be open -> validated -> verified'}, status=400)
    if user_role == 'employee' and new_state != 'verified' or user_role == 'client' and new_state != 'validated':
        return JsonResponse({'error': 'An employee can only verify and a client can only validate an ESG module'}, status=403)

    ModulesESG.objects(id=uuid_module_esg).update(set__state=new_state)
    return HttpResponse("Successful modification")