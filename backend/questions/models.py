from django_cassandra_engine.models import DjangoCassandraModel
from cassandra.cqlengine import columns
from uuid import uuid4

# FORMULAIRE ET REPONSES
class CommitmentPacts(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    id_client = columns.UUID(required=True)
    creation_date = columns.DateTime(required=True)  # Date of the creation of the "Pacte d'engagement"
    answers_commitments = columns.List(columns.UUID(required=True), required=True) # List of answers with isEngagement = True
    calculated_score = columns.Double(required=True)  # Calculated score of the module in validation state

class Challenges(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    index_challenge = columns.Integer(required=True)
    value = columns.Text(required=True)
    color = columns.Text(required=True)  # Hex color code
    sub_challenges = columns.List(columns.UUID(required=True), required=True)

class SubChallenges(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    index_sub_challenge = columns.Integer(required=True)
    value = columns.Text(required=True)
    questions = columns.List(columns.UUID(required=True), required=True)

class Questions(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    index_question = columns.Integer(required=True)
    template = columns.Text(required=True)
    value = columns.Text(required=True)
    type_response = columns.Text(required=True) # qcm, question ouverte ou %
    choices = columns.List(columns.UUID(required=False), required=False)

class Choices(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    index_choice = columns.Integer(required=True)
    value = columns.Text(required=True)
    score = columns.Double(required=True)




