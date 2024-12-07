# views.py
import bcrypt
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
from rest_framework_simplejwt.tokens import RefreshToken
import json
from .models import Users, ClientInformation
from .utils.token_utils import generate_token

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

        # Check if any field is empty
        if username is None or number_workers is None or owned_facility is None or service_or_product is None:
            return JsonResponse({'message': 'All fields are required'}, status=400)

        # Create ClientInformation object
        client_info = ClientInformation.create(number_workers=number_workers, owned_facility=owned_facility,
                                               service_or_product=service_or_product)

        # Create User object
        user = Users.create(username=username, password='password', role='client',
                            id_client_information=client_info.id)

        # Create a random password with BCrypt with the identifier
        identifier = str(user.id)
        password = bcrypt.hashpw(identifier.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
        Users.objects(id=user.id).update(password=password)

        # Generate JWT tokens
        token = generate_token(user.id, username)

        response_data = {
            'message': 'User created successfully',
            'user': {
                'id': str(user.id),
                'username': user.username,
                'role': user.role,
                'client-info-id': str(client_info.id),
                'numberWorkers': client_info.numberWorkers,
                'ownedFacility': client_info.ownedFacility,
                'serviceOrProduct': client_info.serviceOrProduct
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

                client_info = ClientInformation.objects(id=user.id_client_information).first()
                # Prepare response data
                response_data = {
                    'message': 'Authentication successful',
                    'user': {
                        'id': str(user.id),
                        'username': user.username,
                        'role': user.role,
                        'client-info-id': str(client_info.id),
                        'numberWorkers': client_info.numberWorkers,
                        'ownedFacility': client_info.ownedFacility,
                        'serviceOrProduct': client_info.serviceOrProduct
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
