from django_cassandra_engine.models import DjangoCassandraModel
from cassandra.cqlengine import columns
from uuid import uuid4

# FORMULAIRE ET REPONSES
class ModulesESG(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    id_client = columns.UUID(required=True)
    date_last_modification = columns.DateTime(required=True)  # Date of the last modification
    original_answers = columns.List(columns.UUID(required=True), required=True)
    modified_answers = columns.List(columns.UUID(required=True), required=False)
    state = columns.Text(required=True)  # State of the module (e.g., 'open', 'validation', 'verified')
    calculated_score = columns.Double(required=False)  # Calculated score of the module in validation state

class CommitmentPacts(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    id_client = columns.UUID(required=True)
    creation_date = columns.DateTime(required=True)  # Date of the creation of the "Pacte d'engagement"
    answers_commitments = columns.List(columns.UUID(required=True), required=True) # List of answers with isEngagement = True
    calculated_score = columns.Double(required=True)  # Calculated score of the module in validation state

class Answers(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    id_challenge = columns.UUID(required=True)
    id_sub_challenge = columns.UUID(required=True)
    id_question = columns.UUID(required=True)
    id_choice = columns.UUID(required=False)  # Optional, only for QCM type questions
    value = columns.Text(required=True)  # Optional, only for open type questions
    commentary = columns.Text(required=False)  # Commentaire du client
    is_commitment = columns.Boolean(required=True)  # Boolean pour savoir si engagement ou pas
    score_response = columns.Double(required=False)  # Score de la question


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




