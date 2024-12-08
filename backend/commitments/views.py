from django.http import JsonResponse
from django.views.decorators.http import require_GET

from commitments.models import CommitmentPacts
from users.models import Users
from backend.utils.token_utils import decode_token


# Create your views here.


@require_GET
def get_one(request, id):
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

      commitment = CommitmentPacts.get_by_id(id)

      if commitment is None:
         return JsonResponse({'error': 'Commitment not found'}, status=404)

      if not (commitment.id_client == user.id_client_information or user.role == 'employee'):
         return JsonResponse({'error': 'Not Authorized'}, status=403)

      commitment_data =
      return JsonResponse(, safe=False, status=200)

   except Exception as e:
      print(str(e))
      return JsonResponse({'error': str(e)}, status=500)
