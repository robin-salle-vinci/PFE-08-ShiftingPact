from django.http import JsonResponse, HttpResponse
from django.views.decorators.http import require_GET

from backend.utils.json_utils import challenge_json
from backend.utils.token_utils import check_authenticated_user
from questions.models import Challenges, SubChallenges, Questions, Choices


# Create your views here.


@require_GET
def get_all_questions_views(request):
    authenticated_user = check_authenticated_user(request)
    if isinstance(authenticated_user, HttpResponse):
        return authenticated_user

    challenges = Challenges.objects.all()
    challenge_list = []

    for challenge in challenges:
        challenge_list.append(challenge_json(challenge))

    # Retourner les données au format JSON
    return JsonResponse({'challenges': challenge_list}, safe=False)