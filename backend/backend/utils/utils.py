import jwt
import environ
from datetime import datetime, timedelta

from modules.models import Answers
from django.http import JsonResponse

from questions.models import Challenges, SubChallenges, Questions, Choices
from users.models import ClientInformation, Users

env = environ.Env()
environ.Env.read_env()

# Secret key for signing tokens (replace with your Django SECRET_KEY or a separate secret)
SECRET_KEY_JWT = env('SECRET_KEY_JWT')

# Algorithm used for signing the token
ALGORITHM = "HS256"


def generate_token(user_id, username):
  """
  Generates a JWT token.

  :param user_id: The user's unique identifier
  :param username: The user's username
  :param role: The user's role (e.g., 'admin' or 'client')
  :return: Encoded JWT token
  """
  try:
    payload = {
      "id": str(user_id),  # Convert UUID to string
      "username": username,
      "iat": datetime.utcnow(),  # Issued at time
    }
    token = jwt.encode(payload, SECRET_KEY_JWT, algorithm=ALGORITHM)
    return token
  except jwt.PyJWTError as e:
    raise Exception(f"Error generating token: {str(e)}")


def decode_token(token):
  """
  Decodes a JWT token and extracts the payload.

  :param token: Encoded JWT token
  :return: Decoded payload as a dictionary
  """
  try:
    payload = jwt.decode(token, SECRET_KEY_JWT, algorithms=[ALGORITHM])
    return payload
  except jwt.ExpiredSignatureError:
    raise jwt.ExpiredSignatureError("Token has expired")
  except jwt.InvalidTokenError:
    raise jwt.InvalidTokenError("Invalid token")

def check_authenticated_user(request):
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
    return user

def client_info_json(client_info):
  return \
    {
      'id_user': str(client_info.id_user),
      'number_workers': int(client_info.number_workers),
      'owned_facility': str(client_info.owned_facility),
      'service_or_product': str(client_info.service_or_product)
    }

def choice_json(choice):
  return \
    {
      'id': str(choice.id),
      'index_choice': int(choice.index_choice),
      'value': str(choice.value),
      'score': float(choice.score if choice.score else 0),
    }

def question_json(question):
  return \
    {
      'id': str(question.id),
      'index_question': int(question.index_question),
      'value': str(question.value),
      'type_response': str(question.type_response),
      'choices':
        [
          choice_json(choice)
          for choice in (Choices.get_by_id(id_choice) for id_choice in question.choices)
        ]
    }

def sub_challenge_json(sub_challenge):
  return \
    {
      'id': str(sub_challenge.id),
      'index_sub_challenge': int(sub_challenge.index_sub_challenge),
      'value': str(sub_challenge.value),
      'questions':
        [
          question_json(question)
          for question in (Questions.get_by_id(id_question) for id_question in sub_challenge.questions)
        ],
    }

def challenge_json(challenge):
  return \
    {
      'id': str(challenge.id),
      'index_challenge': int(challenge.index_challenge),
      'value': str(challenge.value),
      'color': str(challenge.color),
      'sub_challenges':
        [
          sub_challenge_json(sub_challenge)
          for sub_challenge in (SubChallenges.get_by_id(id_sub_challenge) for id_sub_challenge in challenge.sub_challenges)
        ],
    }

def answer_json(answer):
  return \
    {
      'id': str(answer.id),
      'challenge': challenge_json(Challenges.get_by_id(answer.id_challenge)),
      'sub_challenge': sub_challenge_json(SubChallenges.get_by_id(answer.id_sub_challenge)),
      'question': question_json(Questions.get_by_id(answer.id_question)),
      'value': str(answer.value),
      'commentary': str(answer.commentary),
      'is_commitment': bool(answer.is_commitment),
      'score_response': float(answer.score_response if answer.score_response else 0),
    }

def module_json(module):
  return \
    {
      'id': str(module.id),
      'client_information': client_info_json(ClientInformation.get_by_id(module.id_client)),
      'date_last_modification': module.date_last_modification.isoformat(),
      'original_answers':
        [
          answer_json(answer)
          for answer in (Answers.get_by_id(id_answer) for id_answer in module.original_answers)
        ],
      'modified_answers':
        [
          answer_json(answer)
          for answer in (Answers.get_by_id(id_answer) for id_answer in module.modified_answers)
        ],
      'state': module.state,
      'calculated_score': module.calculated_score
    }

def commitment_json(commitment):
  return \
    {
    'id': str(commitment.id),
    'client_information': client_info_json(ClientInformation.get_by_id(commitment.id_client)),
    'created_date': commitment.created_date.isoformat(),
    'answers_commitments':
      [
        answer_json(answer)
        for answer in (Answers.get_by_id(id_answer) for id_answer in commitment.answers_commitments)
      ],
    'calculated_score': float(commitment.calculated_score),
  }