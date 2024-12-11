from uuid import uuid4

from cassandra.cqlengine import columns
from django_cassandra_engine.models import DjangoCassandraModel


class CommitmentPacts(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    id_client = columns.UUID(required=True)
    creation_date = columns.DateTime(required=True)  # Date of the creation of the "Pacte d'engagement"
    answers_commitments = columns.List(columns.UUID(required=True), required=True)  # List of answers with isEngagement = True

    @classmethod
    def get_by_id(cls, id_commitment_pact):
        return CommitmentPacts.objects.get(id=id_commitment_pact)
