-- Preferable to use command: python manage.py sync_cassandra

DROP KEYSPACE IF EXISTS app;
CREATE KEYSPACE app WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};

-- choices
CREATE TABLE app.Choices
(
    id           uuid PRIMARY KEY,
    index_choice int,
    value        text,
    score        double,
);

-- questions
CREATE TABLE app.Questions
(
    id             uuid PRIMARY KEY,
    index_question int,
    template       text,
    value          text,
    type_response  text,
    choices        list<uuid>
);

-- sub challenges
CREATE TABLE app.SubChallenges
(
    id                  uuid PRIMARY KEY,
    index_sub_challenge int,
    value               text,
    questions           list<uuid>
);

-- challenges
CREATE TABLE app.Challenges
(
    id              uuid PRIMARY KEY,
    index_challenge int,
    value           text,
    color           text,
    sub_challenges  list<uuid>
);

-- answers
CREATE TABLE app.Answers
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
CREATE TABLE app.CommitmentPacts
(
    id                  uuid PRIMARY KEY,
    id_client           uuid,
    creation_date       timestamp,
    answers_commitments list<uuid>
);

-- modules esg
CREATE TABLE app.ModulesESG
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
CREATE TABLE app.Users
(
    id                    uuid PRIMARY KEY,
    username              text,
    password              text,
    role                  text,
    id_client_information uuid
);

-- client information
CREATE TABLE app.ClientInformation
(
    id                 uuid PRIMARY KEY,
    number_workers     int,
    owned_facility     boolean,
    service_or_product text,
    company_name       text,
);
