-- Preferable to use command: python manage.py sync_cassandra

DROP KEYSPACE IF EXISTS app;
CREATE KEYSPACE app WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};

-- choices
CREATE TABLE app.choices
(
    id           uuid PRIMARY KEY,
    index_choice int,
    value        text,
    score        double,
);

-- questions
CREATE TABLE app.questions
(
    id             uuid PRIMARY KEY,
    index_question int,
    template       text,
    value          text,
    type_response  text,
    choices        list<uuid>
);

-- sub challenges
CREATE TABLE app.sub_challenges
(
    id                  uuid PRIMARY KEY,
    index_sub_challenge int,
    value               text,
    questions           list<uuid>
);

-- challenges
CREATE TABLE app.challenges
(
    id              uuid PRIMARY KEY,
    index_challenge int,
    value           text,
    color           text,
    sub_challenges  list<uuid>
);

-- answers
CREATE TABLE app.answers
(
    id               uuid PRIMARY KEY,
    id_challenge     uuid,
    id_sub_challenge uuid,
    id_question      uuid,
    id_choice        uuid,
    value            text,
    commentary       text,
    is_commitment    boolean,
    score_response   double
);

-- commitments pacts
CREATE TABLE app.commitment_pacts
(
    id                  uuid PRIMARY KEY,
    id_client           uuid,
    creation_date       timestamp,
    answers_commitments list<uuid>
);

-- modules esg
CREATE TABLE app.modules_esg
(
    id                     uuid PRIMARY KEY,
    id_client              uuid,
    date_last_modification timestamp,
    original_answers       list<uuid>,
    modified_answers       list<uuid>,
    state                  text,
    calculated_score       double
);

-- users
CREATE TABLE app.users
(
    id                    uuid PRIMARY KEY,
    username              text,
    password              text,
    role                  text,
    id_client_information uuid
);

-- client information
CREATE TABLE app.client_information
(
    id_user            uuid PRIMARY KEY,
    number_workers     int,
    owned_facility     boolean,
    service_or_product text,
    company_name       text,
);
