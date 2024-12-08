from django.http import JsonResponse
from django.shortcuts import render
from django.views.decorators.http import require_POST
from users.models import  Users
from esg.models import ModulesESG
from datetime import datetime
import json

@require_POST
def create_esg_views(request):
    try:
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
