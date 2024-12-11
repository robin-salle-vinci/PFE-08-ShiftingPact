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
            sub_challenge_list = []
            for sub_challenge_id in challenge.sub_challenges:
                sub_challenge = SubChallenges.objects.get(id=sub_challenge_id)
                question_list = []
                for question_id in sub_challenge.questions:
                    question = Questions.objects.get(id=question_id)
                    choice_list = []
                    if question.choices:
                        for choice_id in question.choices:
                            choice = Choices.objects.get(id=choice_id)
                            choice_list.append({
                                'id': str(choice.id),
                                'index_choice': choice.index_choice,
                                'value': choice.value,
                            })
                    question_list.append({
                        'id': str(question.id),
                        'index_question': question.index_question,
                        'template': question.template,
                        'value': question.value,
                        'type_response': question.type_response,
                        'choices': choice_list
                    })
                sub_challenge_list.append({
                    'id': str(sub_challenge.id),
                    'index_sub_challenge': sub_challenge.index_sub_challenge,
                    'value': sub_challenge.value,
                    'questions': question_list
                })
            challenge_list.append({
                'id': str(challenge.id),
                'index_challenge': challenge.index_challenge,
                'value': challenge.value,
                'color': challenge.color,
                'sub_challenges': sub_challenge_list
            })

        # Retourner les données au format JSON
        return JsonResponse({'challenges': challenge_list}, safe=False)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

