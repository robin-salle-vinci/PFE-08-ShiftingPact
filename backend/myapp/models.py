from django_cassandra_engine.models import DjangoCassandraModel
from cassandra.cqlengine import columns


# Create your models here.
class Person(DjangoCassandraModel):
    email = columns.Text(primary_key=True)
