from django.http import JsonResponse
from django.views.decorators.http import require_GET, require_POST
import json
from backend.utils.utils import decode_token, module_json
from modules.models import ModuleESG
from users.models import Users
from datetime import datetime



@require_GET
def read_modules(request):
    try:
        header = request.headers.get('Authorization')
        if not header or not header.startswith('Bearer '):
            return JsonResponse({'error': 'Invalid Authorization header'}, status=400)

        token = header.split(' ')[1]
        if token is None:
            return JsonResponse({'error': 'Token is missing'}, status=401)

        try:
            user_payload = decode_token(token)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=401)

        user = Users.get_by_id(user_payload['id'])

        if user is None:
            return JsonResponse({'Not Found User'}, status=404)

        if user.role != 'employee':
            return JsonResponse({'Not Allowed'}, status=403)


        state_value = request.GET.get('state')

        if state_value is None:
            modules = ModuleESG.get_all()
        else:
            modules = ModuleESG.filter_by_state(state_value)

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
            
        ModuleESG.objects.create(
            id_client=id_client,
            date_last_modification=datetime.today().date(),
            original_answers=[],
            modified_answers=[],
            state="open",
        )
        return JsonResponse({'message': 'Module ESG created successfully'}, status=201)
        
    except Exception as e:
            return JsonResponse({'message': str(e)}, status=500)
