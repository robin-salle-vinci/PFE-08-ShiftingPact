from django_cassandra_engine.models import DjangoCassandraModel
from cassandra.cqlengine import columns
from cassandra.cqlengine.models import Model, UserType

from uuid import uuid4

# Define the Choice UDT as a simple class
class Choice:
    index = columns.Integer(required=True)
    value = columns.Text(required=True)
    score = columns.Double(required=True)

# Define the Question UDT as a simple class
class Question:
    index = columns.Integer(required=True)
    template = columns.Text(required=True)
    value = columns.Text(required=True)
    type_reponse = columns.Text(required=True)
    choices = columns.List(columns.UserDefinedType(Choice), required=False)

# Define the SubChallenge UDT as a simple class
class SubChallenge:
    index = columns.Integer(required=True)
    value = columns.Text(required=True)
    questions = columns.List(columns.UserDefinedType(Question), required=False)

# Define the main Challenge model, inheriting from DjangoCassandraModel
class Challenge(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    index = columns.Integer(required=True)
    value = columns.Text(required=True)
    color = columns.Text(required=True)
    sub_challenges = columns.List(columns.UserDefinedType(SubChallenge), required=True)
