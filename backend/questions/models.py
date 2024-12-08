
from django_cassandra_engine.models import DjangoCassandraModel
from cassandra.cqlengine import columns
from uuid import uuid4

# FORMULAIRE ET REPONSES

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

class Challenges(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    index_challenge = columns.Integer(required=True)
    value = columns.Text(required=True)
    color = columns.Text(required=True)  # Hex color code
    sub_challenges = columns.List(columns.UUID(required=True), required=True)

    @classmethod
    def get_by_id(cls, id_challenge):
        return cls.objects.get(pk=id_challenge)

class SubChallenges(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    index_sub_challenge = columns.Integer(required=True)
    value = columns.Text(required=True)
    questions = columns.List(columns.UUID(required=True), required=True)

    @classmethod
    def get_by_id(cls, id_sub_challenge):
        return cls.objects.get(pk=id_sub_challenge)

class Questions(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    index_question = columns.Integer(required=True)
    template = columns.Text(required=True)
    value = columns.Text(required=True)
    type_response = columns.Text(required=True) # qcm, question ouverte ou %
    choices = columns.List(columns.UUID(required=False), required=False)

    @classmethod
    def get_by_id(cls, id_question):
        return cls.objects.get(pk=id_question)

class Choices(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    index_choice = columns.Integer(required=True)
    value = columns.Text(required=True)
    score = columns.Double(required=True)

    @classmethod
    def get_by_id(cls, id_choice):
        return cls.objects.get(pk=id_choice)