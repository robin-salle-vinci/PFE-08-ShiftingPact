import jwt
import environ
from datetime import datetime, timedelta

from django.http import JsonResponse, HttpResponse

from users.models import Users

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
    raise Exception("Token has expired")
  except jwt.InvalidTokenError:
    raise Exception("Invalid token")


def check_authenticated_user(request):
    header = request.headers.get('Authorization')
    if not header or not header.startswith('Bearer '):
      return HttpResponse("error: 'Invalid Authorization header", status=400)

    token = header.split(' ')[1]
    if token is None:
      return HttpResponse("error: 'Token is missing", status=401)

    try:
      user_payload = decode_token(token)
    except Exception as e:
      return HttpResponse("error: str(e)", status=401)

    user = Users.objects(id=user_payload['id']).first()

    if user is None:
      return HttpResponse('Not Found User', status=404)
    return user
