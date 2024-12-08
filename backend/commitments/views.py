from django.http import JsonResponse
from django.views.decorators.http import require_GET

from backend.utils.utils import commitment_json, check_authenticated_user
from commitments.models import CommitmentPacts
from users.models import Users


# Create your views here.


@require_GET
def get_one(request, id):
   try:

      user = check_authenticated_user(request)
      if isinstance(user, JsonResponse):
         return user

      commitment = CommitmentPacts.get_by_id(id)

      if commitment is None:
         return JsonResponse({'error': 'Commitment not found'}, status=404)

      if not (commitment.id_client == user.id_client_information or user.role == 'employee'):
         return JsonResponse({'error': 'Not Authorized'}, status=403)

      commitment_data = commitment_json(commitment)

      return JsonResponse(commitment_data, safe=False, status=200)

   except Exception as e:
      print(str(e))
      return JsonResponse({'error': str(e)}, status=500)
