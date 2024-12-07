from django.http import JsonResponse
from django.views.decorators.http import require_GET

from backend.utils.token_utils import decode_token
from modules.models import ModuleESG
from questions.models import Answers
from users.models import Users


@require_GET
def read_modules(request):
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

        if user.role != 'employee':
            return JsonResponse({'Not Allowed'}, status=403)


        state_value = request.GET.get('state')

        if state_value is None:
            modules = ModuleESG.get_all()
        else:
            modules = ModuleESG.filter_by_state(state_value)

        modules_data = [{
            'id': str(module.id),
            'id_client': str(module.id_client),
            'date_last_modification': module.date_last_modification.isoformat(),
            'original_answers': [
                {
                    'id': str(answer.id),
                    'id_challenge': str(answer.id_challenge),
                    'id_sub_challenge': str(answer.id_sub_challenge),
                    'id_question': str(answer.id_question),
                    'value': answer.value,
                    'commentary': answer.commentary,
                    'is_commitment': answer.is_commitment,
                    'score_response': answer.score_response,
                } for answer in (Answers.get_by_id(idAnswer) for idAnswer in module.original_answers)
            ],
            'modified_answers': [
                {
                    'id': str(answer.id),
                    'id_challenge': str(answer.id_challenge),
                    'id_sub_challenge': str(answer.id_sub_challenge),
                    'id_question': str(answer.id_question),
                    'value': answer.value,
                    'commentary': answer.commentary,
                    'is_commitment': answer.is_commitment,
                    'score_response': answer.score_response,
                } for answer in (Answers.get_by_id(idAnswer) for idAnswer in module.modified_answers)
            ],
            'state': module.state,
            'calculated_score': module.calculated_score
        } for module in modules]

        return JsonResponse(modules_data, safe=False ,status=200)

    except Exception as e:
        print(str(e))
        return JsonResponse({'error': str(e)}, status=500)