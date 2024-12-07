import jwt
import environ
from datetime import datetime, timedelta

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

