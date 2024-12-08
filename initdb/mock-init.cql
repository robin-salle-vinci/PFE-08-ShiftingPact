INSERT INTO app.users (id, username, password, role)
VALUES (f198ffc1-dcb0-4060-97bf-a77c17747455, 'admin', '$2b$12$e/X6SFG7ckqjkGCrRr3CRec5AFQ6TDYLz2yS85Fl1zCjIFX9uTrgC',
        'employee');

INSERT INTO app.users (id, username, password, role, id_client_information)
VALUES (91cef9b1-c61e-42de-acdc-e81019475fe9, 'client', '$2b$12$e/X6SFG7ckqjkGCrRr3CRec5AFQ6TDYLz2yS85Fl1zCjIFX9uTrgC',
        'client', 91cef9b1-c61e-42de-acdc-e81019475fe9);

INSERT INTO app.client_information (id_user, number_workers, owned_facility, service_or_product)
VALUES (91cef9b1-c61e-42de-acdc-e81019475fe9, 10, False, 'service');


-- Insert Challenges
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES
                                                                               (550e8400-e29b-41d4-a716-446655440000, 1, 'Challenge 1', '#FF5733', [550e8400-e29b-41d4-a716-446655440002, 550e8400-e29b-41d4-a716-446655440003]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES
                                                                               (550e8400-e29b-41d4-a716-446655440001, 2, 'Challenge 2', '#33FF57', [550e8400-e29b-41d4-a716-446655440004, 550e8400-e29b-41d4-a716-446655440005]);

-- Insert SubChallenges for Challenge 1
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions) VALUES
                                                                          (550e8400-e29b-41d4-a716-446655440002, 1, 'SubChallenge 1.1', [550e8400-e29b-41d4-a716-446655440006,550e8400-e29b-41d4-a716-446655440007,550e8400-e29b-41d4-a716-446655440008,550e8400-e29b-41d4-a716-446655440009]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions) VALUES
                                                                          (550e8400-e29b-41d4-a716-446655440003, 2, 'SubChallenge 1.2', [550e8400-e29b-41d4-a716-44665544000A, 550e8400-e29b-41d4-a716-44665544000B, 550e8400-e29b-41d4-a716-44665544000C, 550e8400-e29b-41d4-a716-44665544000D]);

-- Insert SubChallenges for Challenge 2
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions) VALUES
                                                                          (550e8400-e29b-41d4-a716-446655440004, 1, 'SubChallenge 2.1', [550e8400-e29b-41d4-a716-44665544000E, 550e8400-e29b-41d4-a716-44665544000F, 550e8400-e29b-41d4-a716-446655440010, 550e8400-e29b-41d4-a716-446655440011]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions) VALUES
                                                                          (550e8400-e29b-41d4-a716-446655440005, 2, 'SubChallenge 2.2', [550e8400-e29b-41d4-a716-446655440012, 550e8400-e29b-41d4-a716-446655440013, 550e8400-e29b-41d4-a716-446655440014, 550e8400-e29b-41d4-a716-446655440015]);

-- Insert Questions for SubChallenge 1.1
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                        (550e8400-e29b-41d4-a716-446655440006, 1, 'OWNED FACILITY', 'Question 1.1.1', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                        (550e8400-e29b-41d4-a716-446655440007, 2,'WORKERS', 'Question 1.1.2', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                        (550e8400-e29b-41d4-a716-446655440008, 3, 'ALL', 'Question 1.1.3', 'open', null);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                        (550e8400-e29b-41d4-a716-446655440009, 4, 'PRODUITS', 'Question 1.1.4', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);

-- Insert Questions for SubChallenge 1.2
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                        (550e8400-e29b-41d4-a716-44665544000A, 1, 'OWNED FACILITY', 'Question 1.2.1', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                        ( 550e8400-e29b-41d4-a716-44665544000B, 2, 'WORKERS', 'Question 1.2.2', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                                 (550e8400-e29b-41d4-a716-44665544000C, 3, 'ALL', 'Question 1.2.3', 'open', null);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                                 (550e8400-e29b-41d4-a716-44665544000D, 4, 'PRODUITS', 'Question 1.2.4', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);

-- Insert Questions for SubChallenge 2.1
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                        (550e8400-e29b-41d4-a716-44665544000E, 1, 'OWNED FACILITY', 'Question 2.1.1', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                                 (550e8400-e29b-41d4-a716-44665544000F, 2, 'WORKERS', 'Question 2.1.2', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                                 (550e8400-e29b-41d4-a716-446655440010, 3, 'ALL', 'Question 2.1.3', 'open', null);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                                 (550e8400-e29b-41d4-a716-446655440011, 4, 'PRODUITS', 'Question 2.1.4', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);

-- Insert Questions for SubChallenge 2.2
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                        (550e8400-e29b-41d4-a716-446655440012, 1, 'OWNED FACILITY', 'Question 2.2.1', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                                 (550e8400-e29b-41d4-a716-446655440013, 2, 'WORKERS', 'Question 2.2.2', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                                 (550e8400-e29b-41d4-a716-446655440014, 3, 'ALL', 'Question 2.2.3', 'open', null);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES
                                                                                                 (550e8400-e29b-41d4-a716-446655440015, 4, 'PRODUITS', 'Question 2.2.4', 'qcm', [550e8400-e29b-41d4-a716-446655440016, 550e8400-e29b-41d4-a716-446655440017, 550e8400-e29b-41d4-a716-446655440018]);

-- Insert Choices for Questions
INSERT INTO app.choices (id, index_choice, value, score) VALUES
                                                         (550e8400-e29b-41d4-a716-446655440016, 1, 'Oui', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES
                                                         (550e8400-e29b-41d4-a716-446655440017, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES
                                                         (550e8400-e29b-41d4-a716-446655440018, 3, 'N/A', 1.0);

-- Insert Users (password: admin)
INSERT INTO app.users (id, username, password, role)
VALUES (550e8400-e29b-41d4-a716-446655440019, 'admin', '$2b$12$e/X6SFG7ckqjkGCrRr3CRec5AFQ6TDYLz2yS85Fl1zCjIFX9uTrgC','employee');

INSERT INTO app.users (id, username, password, role, id_client_information)
VALUES (550e8400-e29b-41d4-a716-446655440020, 'client_open', '$2b$12$e/X6SFG7ckqjkGCrRr3CRec5AFQ6TDYLz2yS85Fl1zCjIFX9uTrgC','client', 550e8400-e29b-41d4-a716-446655440020);

INSERT INTO app.users (id, username, password, role, id_client_information)
VALUES (550e8400-e29b-41d4-a716-446655440021, 'client_validation', '$2b$12$e/X6SFG7ckqjkGCrRr3CRec5AFQ6TDYLz2yS85Fl1zCjIFX9uTrgC','client', 550e8400-e29b-41d4-a716-446655440021);

INSERT INTO app.users (id, username, password, role, id_client_information)
VALUES (550e8400-e29b-41d4-a716-446655440022, 'client_verified', '$2b$12$e/X6SFG7ckqjkGCrRr3CRec5AFQ6TDYLz2yS85Fl1zCjIFX9uTrgC','client', 550e8400-e29b-41d4-a716-446655440022);

-- Insert Client Information
INSERT INTO app.client_information (id_user, number_workers, owned_facility, service_or_product)
VALUES (550e8400-e29b-41d4-a716-446655440020, 10, False, 'service');

INSERT INTO app.client_information (id_user, number_workers, owned_facility, service_or_product)
VALUES (550e8400-e29b-41d4-a716-446655440021, 0, False, 'produit');

INSERT INTO app.client_information (id_user, number_workers, owned_facility, service_or_product)
VALUES (550e8400-e29b-41d4-a716-446655440022, 1, True, 'service');

-- Insert Modules ESG
INSERT INTO app.module_esg (id, id_client, date_last_modification, original_answers, modified_answers ,state, calculated_score)
VALUES (550e8400-e29b-41d4-a716-446655440023, 550e8400-e29b-41d4-a716-446655440020, '2022-07-12T00:00:00Z', [550e8400-e29b-41d4-a716-446655440027, 550e8400-e29b-41d4-a716-446655440028, 550e8400-e29b-41d4-a716-446655440029, 550e8400-e29b-41d4-a716-446655440030, 550e8400-e29b-41d4-a716-446655440031, 550e8400-e29b-41d4-a716-446655440032, 550e8400-e29b-41d4-a716-446655440033, 550e8400-e29b-41d4-a716-446655440034, 550e8400-e29b-41d4-a716-446655440035, 550e8400-e29b-41d4-a716-446655440036, 550e8400-e29b-41d4-a716-446655440037, 550e8400-e29b-41d4-a716-446655440038, 550e8400-e29b-41d4-a716-446655440039, 550e8400-e29b-41d4-a716-446655440040, 550e8400-e29b-41d4-a716-446655440041, 550e8400-e29b-41d4-a716-446655440042],[550e8400-e29b-41d4-a716-446655440043, 550e8400-e29b-41d4-a716-446655440044, 550e8400-e29b-41d4-a716-446655440045], 'verified', 6.8);

INSERT INTO app.module_esg (id, id_client, date_last_modification, original_answers, state)
VALUES (550e8400-e29b-41d4-a716-446655440024, 550e8400-e29b-41d4-a716-446655440020, '2024-12-08T00:00:00Z', [550e8400-e29b-41d4-a716-446655440027, 550e8400-e29b-41d4-a716-446655440028, 550e8400-e29b-41d4-a716-446655440029, 550e8400-e29b-41d4-a716-446655440030, 550e8400-e29b-41d4-a716-446655440031, 550e8400-e29b-41d4-a716-446655440032, 550e8400-e29b-41d4-a716-446655440033, 550e8400-e29b-41d4-a716-446655440034, 550e8400-e29b-41d4-a716-446655440035, 550e8400-e29b-41d4-a716-446655440036, 550e8400-e29b-41d4-a716-446655440037, 550e8400-e29b-41d4-a716-446655440038], 'open');

INSERT INTO app.module_esg (id, id_client, date_last_modification, original_answers, modified_answers ,state)
VALUES (550e8400-e29b-41d4-a716-446655440025, 550e8400-e29b-41d4-a716-446655440021, '2024-12-08T00:00:00Z', [550e8400-e29b-41d4-a716-446655440027, 550e8400-e29b-41d4-a716-446655440028, 550e8400-e29b-41d4-a716-446655440029, 550e8400-e29b-41d4-a716-446655440030, 550e8400-e29b-41d4-a716-446655440031, 550e8400-e29b-41d4-a716-446655440032, 550e8400-e29b-41d4-a716-446655440033, 550e8400-e29b-41d4-a716-446655440034, 550e8400-e29b-41d4-a716-446655440035, 550e8400-e29b-41d4-a716-446655440036, 550e8400-e29b-41d4-a716-446655440037, 550e8400-e29b-41d4-a716-446655440038, 550e8400-e29b-41d4-a716-446655440039, 550e8400-e29b-41d4-a716-446655440040, 550e8400-e29b-41d4-a716-446655440041, 550e8400-e29b-41d4-a716-446655440042], [550e8400-e29b-41d4-a716-446655440043, 550e8400-e29b-41d4-a716-446655440044, 550e8400-e29b-41d4-a716-446655440045], 'validated');

INSERT INTO app.module_esg (id, id_client, date_last_modification, original_answers, modified_answers ,state, calculated_score)
VALUES (550e8400-e29b-41d4-a716-446655440026, 550e8400-e29b-41d4-a716-446655440022, '2024-12-08T00:00:00Z', [550e8400-e29b-41d4-a716-446655440027, 550e8400-e29b-41d4-a716-446655440028, 550e8400-e29b-41d4-a716-446655440029, 550e8400-e29b-41d4-a716-446655440030, 550e8400-e29b-41d4-a716-446655440031, 550e8400-e29b-41d4-a716-446655440032, 550e8400-e29b-41d4-a716-446655440033, 550e8400-e29b-41d4-a716-446655440034, 550e8400-e29b-41d4-a716-446655440035, 550e8400-e29b-41d4-a716-446655440036, 550e8400-e29b-41d4-a716-446655440037, 550e8400-e29b-41d4-a716-446655440038, 550e8400-e29b-41d4-a716-446655440039, 550e8400-e29b-41d4-a716-446655440040, 550e8400-e29b-41d4-a716-446655440041, 550e8400-e29b-41d4-a716-446655440042],[550e8400-e29b-41d4-a716-446655440043, 550e8400-e29b-41d4-a716-446655440044, 550e8400-e29b-41d4-a716-446655440045], 'verified', 6.8);

-- Insert Original Answers
INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440027, 550e8400-e29b-41d4-a716-446655440000, 550e8400-e29b-41d4-a716-446655440002, 550e8400-e29b-41d4-a716-446655440006, 550e8400-e29b-41d4-a716-446655440016, 'Oui', True);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440028, 550e8400-e29b-41d4-a716-446655440000, 550e8400-e29b-41d4-a716-446655440002, 550e8400-e29b-41d4-a716-446655440007, 550e8400-e29b-41d4-a716-446655440017, 'Non', True);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, commentary, value ,is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440029, 550e8400-e29b-41d4-a716-446655440000, 550e8400-e29b-41d4-a716-446655440002, 550e8400-e29b-41d4-a716-446655440008, 'Commentaire', '43',True);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440030, 550e8400-e29b-41d4-a716-446655440000, 550e8400-e29b-41d4-a716-446655440002, 550e8400-e29b-41d4-a716-446655440009, 550e8400-e29b-41d4-a716-446655440018, 'N/A', False);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440031, 550e8400-e29b-41d4-a716-446655440000, 550e8400-e29b-41d4-a716-446655440003, 550e8400-e29b-41d4-a716-44665544000A, 550e8400-e29b-41d4-a716-446655440016, 'Oui', False);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440032, 550e8400-e29b-41d4-a716-446655440000, 550e8400-e29b-41d4-a716-446655440003, 550e8400-e29b-41d4-a716-44665544000B, 550e8400-e29b-41d4-a716-446655440017, 'Non', True);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, commentary,value , is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440033, 550e8400-e29b-41d4-a716-446655440000, 550e8400-e29b-41d4-a716-446655440003, 550e8400-e29b-41d4-a716-44665544000C, 'Commentaire', '12',False);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440034, 550e8400-e29b-41d4-a716-446655440000, 550e8400-e29b-41d4-a716-446655440003, 550e8400-e29b-41d4-a716-44665544000D, 550e8400-e29b-41d4-a716-446655440018, 'N/A', False);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440035, 550e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440004, 550e8400-e29b-41d4-a716-44665544000E, 550e8400-e29b-41d4-a716-446655440016, 'Oui', False);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440036, 550e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440004, 550e8400-e29b-41d4-a716-44665544000F, 550e8400-e29b-41d4-a716-446655440017, 'Non', False);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, commentary,value , is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440037, 550e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440004, 550e8400-e29b-41d4-a716-446655440010, 'Commentaire', '76',True);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440038, 550e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440004, 550e8400-e29b-41d4-a716-446655440011, 550e8400-e29b-41d4-a716-446655440018, 'N/A', False);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440039, 550e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440005, 550e8400-e29b-41d4-a716-446655440012, 550e8400-e29b-41d4-a716-446655440016, 'Oui', False);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440040, 550e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440005, 550e8400-e29b-41d4-a716-446655440013, 550e8400-e29b-41d4-a716-446655440017, 'Non', True);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, commentary,value , is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440041, 550e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440005, 550e8400-e29b-41d4-a716-446655440014, 'Commentaire', 'Chauffage', True);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440042, 550e8400-e29b-41d4-a716-446655440001, 550e8400-e29b-41d4-a716-446655440005, 550e8400-e29b-41d4-a716-446655440015, 550e8400-e29b-41d4-a716-446655440018, 'N/A', False);

-- Insert Modified Answers
INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440043, 550e8400-e29b-41d4-a716-446655440000, 550e8400-e29b-41d4-a716-446655440002, 550e8400-e29b-41d4-a716-446655440006, 550e8400-e29b-41d4-a716-446655440016, 'Oui', False);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, id_choice, value, is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440044, 550e8400-e29b-41d4-a716-446655440000, 550e8400-e29b-41d4-a716-446655440002, 550e8400-e29b-41d4-a716-446655440007, 550e8400-e29b-41d4-a716-446655440017, 'Non', False);

INSERT INTO app.answers (id, id_challenge, id_sub_challenge, id_question, commentary,value , is_commitment)
VALUES (550e8400-e29b-41d4-a716-446655440045, 550e8400-e29b-41d4-a716-446655440000, 550e8400-e29b-41d4-a716-446655440002, 550e8400-e29b-41d4-a716-446655440008, 'Commentaire', 'Secteur Horeca', False);

-- Insert Commitment Pact
INSERT INTO app.commitment_pacts (id, id_client, creation_date, answers_commitments)
VALUES (550e8400-e29b-41d4-a716-446655440046, 550e8400-e29b-41d4-a716-446655440020, '2022-07-12T00:00:00Z', [550e8400-e29b-41d4-a716-446655440032, 550e8400-e29b-41d4-a716-446655440037, 550e8400-e29b-41d4-a716-446655440040, 550e8400-e29b-41d4-a716-446655440041]);

INSERT INTO app.commitment_pacts (id, id_client, creation_date, answers_commitments)
VALUES (550e8400-e29b-41d4-a716-446655440047, 550e8400-e29b-41d4-a716-446655440022, '2024-12-08T00:00:00Z', [550e8400-e29b-41d4-a716-446655440032, 550e8400-e29b-41d4-a716-446655440037, 550e8400-e29b-41d4-a716-446655440040, 550e8400-e29b-41d4-a716-446655440041]);
