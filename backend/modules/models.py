from uuid import uuid4
from cassandra.cqlengine import columns
from django_cassandra_engine.models import DjangoCassandraModel


class ModuleESG(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    id_client = columns.UUID(required=True)
    date_last_modification = columns.DateTime(required=True)  # Date of the last modification
    original_answers = columns.List(columns.UUID(required=True), required=True)
    modified_answers = columns.List(columns.UUID(required=True), required=False)
    state = columns.Text(required=True)  # State of the module (e.g., 'open', 'validation', 'verified')
    calculated_score = columns.Double(required=False)  # Calculated score of the module in validation state

    @classmethod
    def get_all(cls):
        return cls.objects.all()

    @classmethod
    def filter_by_state(cls, state_value):
        return cls.objects.all().filter(state=state_value)
class CommitmentPacts(DjangoCassandraModel):
    id = columns.UUID(primary_key=True, default=uuid4)
    id_client = columns.UUID(required=True)
    creation_date = columns.DateTime(required=True)  # Date of the creation of the "Pacte d'engagement"
    answers_commitments = columns.List(columns.UUID(required=True), required=True)  # List of answers with isEngagement = True
