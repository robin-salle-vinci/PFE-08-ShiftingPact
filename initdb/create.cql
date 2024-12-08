CREATE TABLE IF NOT EXISTS app.Commitment_Pacts (
    id UUID PRIMARY KEY,
    id_client UUID,
    creation_date TIMESTAMP,
    answers_commitments LIST<UUID>
);

CREATE TABLE IF NOT EXISTS app.Module_ESG (
    id UUID PRIMARY KEY,
    id_client UUID,
    date_last_modification TIMESTAMP,
    original_answers LIST<UUID>,
    modified_answers LIST<UUID>,
    state TEXT,
    calculated_score DOUBLE
);

CREATE TABLE IF NOT EXISTS app.Users (
    id UUID PRIMARY KEY,
    username TEXT,
    password TEXT,
    role TEXT,
    id_client_information UUID
);

CREATE TABLE IF NOT EXISTS app.Client_Information (
    id_user UUID PRIMARY KEY,
    number_workers INT,
    owned_facility BOOLEAN,
    service_or_product TEXT
);

CREATE TABLE IF NOT EXISTS app.Choices (
    id UUID PRIMARY KEY,
    index_choice INT,
    value TEXT,
    score DOUBLE
);

CREATE TABLE IF NOT EXISTS app.Questions (
    id UUID PRIMARY KEY,
    index_question INT,
    template TEXT,
    value TEXT,
    type_response TEXT,
    choices LIST<UUID>
);

CREATE TABLE IF NOT EXISTS app.Sub_Challenges (
    id UUID PRIMARY KEY,
    index_sub_challenge INT,
    value TEXT,
    questions LIST<UUID>
);

CREATE TABLE IF NOT EXISTS app.Challenges (
    id UUID PRIMARY KEY,
    index_challenge INT,
    value TEXT,
    color TEXT,  -- Hex color code
    sub_challenges LIST<UUID>
);

CREATE TABLE IF NOT EXISTS app.Answers (
    id UUID PRIMARY KEY,
    id_challenge UUID,
    id_sub_challenge UUID,
    id_question UUID,
    id_choice UUID,  -- Optional, only for QCM type questions
    value TEXT,      -- Required for open type questions
    commentary TEXT, -- Optional commentary from the client
    is_commitment BOOLEAN,  -- Boolean to indicate commitment
    score_response DOUBLE    -- Optional score for the question
);
