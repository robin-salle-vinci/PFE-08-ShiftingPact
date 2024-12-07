from django.http import JsonResponse
from django.shortcuts import render
from django.views.decorators.http import require_GET

from questions.models import Challenges, SubChallenges, Questions, Choices


# Create your views here.


@require_GET
def get_all_questions_views(request):
    challenges = Challenges.objects.all()
    challenge_list = []

    for challenge in challenges:
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
                            'indexation_choice': choice.indexation_choice,
                            'value': choice.value,
                            'score': choice.score
                        })
                question_list.append({
                    'id': str(question.id),
                    'indexation_question': question.indexation_question,
                    'template': question.template,
                    'value': question.value,
                    'type_response': question.type_response,
                    'choices': choice_list
                })
            sub_challenge_list.append({
                'id': str(sub_challenge.id),
                'indexation_sub_challenge': sub_challenge.indexation_sub_challenge,
                'value': sub_challenge.value,
                'questions': question_list
            })
        challenge_list.append({
            'id': str(challenge.id),
            'indexation_challenge': challenge.indexation_challenge,
            'value': challenge.value,
            'color': challenge.color,
            'sub_challenges': sub_challenge_list
        })

    # Retourner les données au format JSON
    return JsonResponse({'challenges': challenge_list}, safe=False)