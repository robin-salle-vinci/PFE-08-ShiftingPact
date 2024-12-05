
from django_cassandra_engine.models import DjangoCassandraModel
from cassandra.cqlengine import columns
from uuid import uuid4, UUID

def generate_base36_id():
    """Génère un ID unique en base 36."""
    uuid_value = UUID(int=uuid4().int)
    return uuid_value.int.to_bytes((uuid_value.int.bit_length() + 7) // 8, 'big').hex()


class Questions(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    challenge = columns.Text(required=True)     # enjeux/catégorie en vert dans excel
    sub_challenge = columns.Text(required=True) # sous-enjeux
    template = columns.Text(required=True)      # worker,..
    type_response = columns.Text(required=True) # QCM, question ouverte,...
    value = columns.Text(required=True)         # le contenu de la question


class Responses(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    id_client = columns.Integer(primary_key=True)
    id_question = columns.Integer(primary_key=True)
    comment = columns.Text(required=False)                     # commentaire du client
    isEngagement = columns.Boolean(required=True)              # boolean pour savoir si engagement ou pas
    value = columns.Text(required=True)                        # valeur de la réponse
    score_response = columns.Double(required=True)             # score de la question ouverte
    date_modification = columns.DateTime(required=True)
    class Meta:
        get_pk_field = 'id'

class ChoicesQCM(DjangoCassandraModel):
    id = columns.Text(primary_key=True, default=generate_base36_id) # génère une clé primaire a,b,c,...
    id_question = columns.Integer(primary_key=True)
    score_choice = columns.Double(required=True)                    # score du choix
    value = columns.Text(required=True)                             # le contenu du choix
    class Meta:
        get_pk_field = 'id'                                         # indique que la clé principale est id