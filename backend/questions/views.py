from django.http import JsonResponse, HttpResponse
from django.views.decorators.http import require_GET

from backend.utils.json_utils import challenge_json
from backend.utils.token_utils import check_authenticated_user
from questions.models import Challenges, SubChallenges, Questions, Choices


# Create your views here.


@require_GET
def get_all_questions_views(request):
    try:
        authenticated_user = check_authenticated_user(request)
        if isinstance(authenticated_user, HttpResponse):
            return authenticated_user
        
        challenges = Challenges.objects.all()
        challenge_list = []

        for challenge in sorted(challenges, key=lambda c: c.index_challenge):
            challenge_list.append(challenge_json(challenge))

        # Retourner les données au format JSON
        return JsonResponse({'challenges': challenge_list}, safe=False)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

