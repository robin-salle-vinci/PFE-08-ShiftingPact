# views.py
from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
import json
from datetime import datetime
from .models import Users

@csrf_exempt
@require_POST  # Only allow POST requests
def login_view(request):
    try:
        data = json.loads(request.body)
        username = data.get('email')
        password = data.get('password')

        # Check if username or password is empty
        if not username or not password:
            return JsonResponse({'message': 'Username or password cannot be empty'},status=400)

        # Check if credentials exist in Cassandra DB
        user = Users.objects(username=username).first()

        if user:
            # Check if password matches
            if user.password == password:
                # Check role and handle accordingly
                if user.role == 'admin':
                    return JsonResponse({'message': 'Authentication successful as admin'},status=200)
                elif user.role == 'client':
                    return JsonResponse({'message': f'Authentication successful as client, info_client_id: {user.id_info_client}'}, status=200)
            else:
                return JsonResponse({'message': 'Invalid credentials'}, status=401)
        else:
            return JsonResponse({'message': 'User not found'}, status=404)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)