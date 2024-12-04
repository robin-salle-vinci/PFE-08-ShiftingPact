from django_cassandra_engine.models import DjangoCassandraModel
from cassandra.cqlengine import columns

class Person(DjangoCassandraModel):
    # Primary key defined here
    email = columns.Text(primary_key=True)  # Partition key (email is the unique identifier)
    name = columns.Text()                   # Additional fields for the Person
    age = columns.Integer()   