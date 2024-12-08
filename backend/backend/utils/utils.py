import jwt
import environ
from datetime import datetime, timedelta

from questions.models import Challenges, SubChallenges, Questions, Choices, Answers
from users.models import ClientInformation

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


def client_info_json(client_info):
  return \
    {
      'id_user': str(client_info.id_user),
      'number_workers': int(client_info.number_workers),
      'owner_facility': str(client_info.owner_facility),
      'service_or_product': str(client_info.service_or_product)
    }

def choice_json(choice):
  return \
    {
      'id': str(choice.id),
      'index_choice': int(choice.index_choice),
      'value': str(choice.value),
      'score': float(choice.score),
    }

def question_json(question):
  return \
    {
      'id': str(question.id),
      'index_choice': int(question.index_choice),
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
      'score_response': float(answer.score_response),
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
          for answer in (Answers.get_by_id(idAnswer) for idAnswer in module.original_answers)
        ],
      'modified_answers':
        [
          answer_json(answer)
          for answer in (Answers.get_by_id(idAnswer) for idAnswer in module.modified_answers)
        ],
      'state': module.state,
      'calculated_score': module.calculated_score
    }