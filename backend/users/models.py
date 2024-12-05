from django_cassandra_engine.models import DjangoCassandraModel
from cassandra.cqlengine import columns
from uuid import uuid4

class Users(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)  # Use UUID for unique ID
    username = columns.Text(required=True)
    password = columns.Text(required=True)
    role = columns.Text(required=True)  # Role as 'admin' or 'client'
    id_info_client = columns.Integer(required=False)  # Optional field for 'client' role, will link to InfoClient later


