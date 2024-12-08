from django_cassandra_engine.models import DjangoCassandraModel
from cassandra.cqlengine import columns
from uuid import uuid4

class Users(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)  # Use UUID for unique ID
    username = columns.Text(required=True)
    password = columns.Text(required=True)
    role = columns.Text(required=True)  # Role as 'employee' or 'client'
    id_client_information = columns.UUID(required=False)  # Optional field for 'client' role

    @classmethod
    def get_by_id(cls, id_user):
        return cls.objects.get(id=id_user)


# Create this before creating User
class ClientInformation(DjangoCassandraModel):
    id_user = columns.UUID(primary_key=True)
    number_workers = columns.Integer(required=True)
    owned_facility = columns.Boolean(required=True)
    service_or_product = columns.Text(required=True)
