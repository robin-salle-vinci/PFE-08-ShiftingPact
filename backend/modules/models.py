from uuid import uuid4
from cassandra.cqlengine import columns
from cassandra.cqlengine.usertype import UserType


class Answers(UserType):
    id_challenge = columns.UUID(required=True)
    id_sub_challenge = columns.UUID(required=True)
    id_question = columns.UUID(required=True)
    id_choice = columns.UUID(required=False)  # Optional, only for QCM type questions
    value = columns.Text(required=True)  # Optional, only for open type questions
    commentary = columns.Text(required=False)  # Commentaire du client
    isEngagement = columns.Boolean(required=True)  # Boolean pour savoir si engagement ou pas
    score_response = columns.Double(required=False)  # Score de la question ouverte


class Users(UserType):
    id = columns.UUID(required=True)  # Use UUID for unique ID
    username = columns.Text(required=True)
    password = columns.Text(required=True)
    role = columns.Text(required=True)  # Role as 'employee' or 'client'
    id_client_information = columns.UUID(required=False)

    @classmethod
    def get_by_id(cls, idUser):
        return cls.objects.get(pk=idUser)

class ModuleESG(UserType):
    id = columns.UUID(primary_key=True, default=uuid4)
    id_client = columns.UUID(primary_key=True)
    date_last_modification = columns.DateTime(required=True)  # Date of the last modification or the creation of the "Pacte d'engagement"
    original_answers = columns.List(columns.UserDefinedType(Answers), required=True)
    modified_answers = columns.List(columns.UserDefinedType(Answers), required=False)
    state = columns.Text(required=True)  # State of the module (e.g., 'open', 'validation', 'verified')
    calculated_score = columns.Double(required=False)  # Calculated score of the module in validation state

    @classmethod
    def get_all(cls):
        return cls.objects.all()

    @classmethod
    def filter_by_state(cls, state_value):
        return cls.objects.all().filter(state=state_value)

    class Meta:
        get_pk_field = 'id'
