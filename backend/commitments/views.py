from django.http import JsonResponse
from django.views.decorators.http import require_GET

from backend.utils.json_utils import commitment_json
from backend.utils.token_utils import check_authenticated_user
from commitments.models import CommitmentPacts

# Create your views here.


# read all commitment for a specific client
@require_GET
def get_all_client(request, id_client):
   try:

      user = check_authenticated_user(request)
      if isinstance(user, JsonResponse):
         return user

      if not (id_client == user.id or user.role == 'employee'):
         return JsonResponse({'error': 'Not Authorized'}, status=403)

      commitments = CommitmentPacts.objects.all().filter(id_client=id_client)

      commitment_data = [ commitment_json(commitment) for commitment in commitments]

      return JsonResponse(commitment_data, safe=False, status=200)

   except Exception as e:
      print(str(e))
      return JsonResponse({'error': str(e)}, status=500)


# read one commitment by id
@require_GET
def get_one(request, id_commitment):
   try:

      user = check_authenticated_user(request)
      if isinstance(user, JsonResponse):
         return user

      commitment = CommitmentPacts.get_by_id(str(id_commitment))

      if commitment is None:
         return JsonResponse({'error': 'Commitment not found'}, status=404)

      if not (commitment.id_client == user.id or user.role == 'employee'):
         return JsonResponse({'error': 'Not Authorized'}, status=403)

      commitment_data = commitment_json(commitment)

      return JsonResponse(commitment_data, safe=False, status=200)

   except Exception as e:
      print(str(e))
      return JsonResponse({'error': str(e)}, status=500)
   

