# views.py
from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from datetime import datetime
from .models import User

@csrf_exempt
def login_view(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            username = data.get('username')
            password = data.get('password')

            # Check if credentials exist in Cassandra DB
            user = User.objects(username=username).first()

            if user:
                # Check if password matches
                if user.password == password:
                    # Check role and handle accordingly
                    if user.role == 'admin':
                        return JsonResponse(
                            {'message': 'Authentication successful as admin'},
                            status=200)
                    elif user.role == 'client':
                        return JsonResponse({'message': f'Authentication successful as client, info_client_id: {user.id_info_client}'}, status=200)
                else:
                    return JsonResponse({'message': 'Invalid credentials'}, status=401)
            else:
                return JsonResponse({'message': 'User not found'}, status=404)

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)
    else:
        return JsonResponse({'error': 'Method not allowed'}, status=405)