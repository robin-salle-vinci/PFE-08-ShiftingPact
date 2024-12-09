# views.py
import bcrypt
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
import json
import re

from backend.utils.token_utils import generate_token
from .models import Users, ClientInformation

@csrf_exempt
@require_POST  # Only allow POST requests
def register_view(request):
    try:
        data = json.loads(request.body)
        company_name = data.get('companyName')
        number_workers = data.get('numberWorkers')
        owned_facility = data.get('facilityOwner')
        service_or_product = 'service' if data.get('isService') else 'product'

        # Change the companyName to username
        username = company_name.replace(' ', '').lower()
        username = re.sub(r'[^a-z0-9-_]', '', username)

        # Check if username already exists
        if Users.objects(username=username).first():
            return JsonResponse({'message': 'Username already exists'}, status=409)

        # Check if any field is empty
        if username is None or number_workers is None or owned_facility is None or service_or_product is None:
            return JsonResponse({'message': 'All fields are required'}, status=400)

        # Create User object
        user = Users.create(username=username, password='password', role='client')

        # Create ClientInformation object
        client_info = ClientInformation.create(id_user=user.id, number_workers=number_workers, owned_facility=owned_facility,
                                               service_or_product=service_or_product, company_name=company_name)

        Users.objects(id=user.id).update(id_client_information=client_info.id_user)

        # Create a random password with BCrypt with the identifier
        identifier = str(user.id)
        password = bcrypt.hashpw(identifier.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
        Users.objects(id=user.id).update(password=password)

        # Generate JWT tokens
        try:
            token = generate_token(user.id, username)
        except:
            return JsonResponse({'message': 'Impossible to generate a token'}, status=500)

        response_data = {
            'message': 'User created successfully',
            'user': {
                'id': str(user.id),
                'username': user.username,
                'role': user.role,
                'client-info-id': str(client_info.id_user),
                'numberWorkers': client_info.number_workers,
                'ownedFacility': client_info.owned_facility,
                'serviceOrProduct': client_info.service_or_product
            },
            'token': token,
            'password': identifier
        }

        # add password to the response
        if user:
            return JsonResponse(response_data, status=201)
        else:
            return JsonResponse({'message': 'User creation failed'}, status=500)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


@csrf_exempt
@require_POST  # Only allow POST requests
def login_view(request):
    try:
        data = json.loads(request.body)
        username = data.get('username')
        password = data.get('password')

        # Check if username or password is empty
        if not username or not password:
            return JsonResponse({'message': 'Username or password cannot be empty'}, status=400)

        # Check if credentials exist in Cassandra DB
        user = Users.objects(username=username).first()


        if user:
            # Check if password matches
            if bcrypt.checkpw(password.encode('utf-8'), user.password.encode('utf-8')):
                token = generate_token(user.id, username)

                # Prepare response data
                if user.role != 'employee':
                    client_info = ClientInformation.objects(id_user=user.id_client_information).first()
                    # Prepare response data
                    response_data = {
                        'message': 'Authentication successful as client',
                        'user': {
                            'id': str(user.id),
                            'username': user.username,
                            'role': user.role,
                            'client-info-id': str(client_info.id_user),
                            'numberWorkers': client_info.number_workers,
                            'ownedFacility': client_info.owned_facility,
                            'serviceOrProduct': client_info.service_or_product
                        },
                        'token': token
                    }
                else:
                    response_data = {
                        'message': 'Authentication successful as employee',
                        'user': {
                            'id': str(user.id),
                            'username': user.username,
                            'role': user.role,
                        },
                        'token': token
                    }

                return JsonResponse(response_data, status=200)
            else:
                return JsonResponse({'message': 'Invalid credentials'}, status=401)
        else:
            return JsonResponse({'message': 'User not found'}, status=404)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
