from uuid import uuid4
from cassandra.cqlengine import columns
from django_cassandra_engine.models import DjangoCassandraModel

class ModulesESG(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    id_client = columns.UUID(required=True)
    date_last_modification = columns.DateTime(required=True)  # Date of the last modification
    original_answers = columns.List(columns.UUID(required=True), required=True)
    modified_answers = columns.List(columns.UUID(required=True), required=False)
    state = columns.Text(required=True)  # State of the module (e.g., 'open', 'validated', 'verified')
    calculated_score = columns.Double(required=False)  # Calculated score of the module in validation state

    @classmethod
    def get_by_id(cls,id_module_esg):
        return cls.objects.get(pk=id_module_esg)

    @classmethod
    def get_most_recent_by_client_id(cls, id_client):
        return cls.objects.filter(id_client=id_client).order_by('-date_last_modification').first()

    @classmethod
    def get_all(cls):
        return cls.objects.all()

    @classmethod
    def filter_by_state(cls, state_value):
        return cls.objects.all().filter(state=state_value)

    @classmethod
    def filter_by_client_id(cls, id_client):
        return cls.objects.all().filter(id_client=id_client)


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

    @classmethod
    def get_by_id(cls, id_answer):
        return cls.objects.get(pk=id_answer)