DROP KEYSPACE IF EXISTS app;
CREATE KEYSPACE app WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

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

-- Insert Choices
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c296871c-8e85-48d6-ae7f-5ad455a106b2, 1, ' Oui', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (12f9f09f-0c99-4328-8098-fb7c23ce97cb, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (299d1c40-1d22-4fdb-a21a-0a1494edf980, 1, 'Oui', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e825f22b-b58d-4b69-bb27-bc0429e0b65e, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2eeefed7-73ce-4241-bcbb-d33805494900, 3, 'Je ne sais pas', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d2f86ebd-7dd0-40ed-b78a-d3e9a4b4859e, 4, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (6557d2fe-434b-4770-95a5-9bc07246ef21, 1, 'Oui', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (baa21c6d-ee13-43ba-8921-dddb0be6b6d4, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b12f7309-312d-4499-95c3-d0781fe1892e, 3, 'Je ne sais pas', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (04e7f911-c973-415e-af92-76f0f932a986, 4, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f0037730-4d5b-4426-ac09-17411d4ce3b7, 1, 'Nous avons investi dans des équipements de bureau économes en énergie, notamment des ordinateurs, des imprimantes, etc.', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (66457af2-bef1-4d73-a8c2-08b4b825c58c, 2, 'Nous avons remplacé les ampoules traditionnelles par des ampoules LED à haut rendement énergétique afin de réduire la consommation d''électricité.', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0ca28dc6-3377-4a69-9d77-1338efaee097, 3, 'Nous avons installé des thermostats intelligents pour optimiser les systèmes de chauffage, de ventilation et de climatisation (CVC) en vue d''une meilleure efficacité énergétique.', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (32d5c7cb-9530-4879-85e6-55dc179a1cdb, 4, 'Nous réalisons régulièrement des audits énergétiques afin d''identifier les points à améliorer et d''optimiser notre consommation d''énergie.', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (04f4e97b-65e0-4f89-ab3f-63033e195bf7, 5, 'Nous avons installé des détecteurs de présence pour l''éclairage et les systèmes CVC afin d''ajuster automatiquement la consommation en fonction des niveaux d''occupation.', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b0a05fc2-74ec-47f4-a3a2-df07d66b7e51, 6, 'Autre : veuillez expliquer dans les commentaires', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (67043484-5411-4cf1-820b-1ef375849b74, 7, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5905c1d4-036a-4b74-996f-c9e25d0bad65, 8, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (254e48ea-535a-4cb1-9d58-589484f0ed74, 1, 'Oui', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ee38c137-4a72-4ba4-a54c-4bcdd1480ae4, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c425e2c9-b430-4db0-85a6-f4dc4c1419ff, 3, 'N/A - Nous n''avons pas de travailleur·euses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5e5fd806-1c88-4aa4-a19c-d99ed8788e1c, 1, 'Oui, pour les Scopes 1 & 2 (les émissions de gaz à effet de serre directes et indirectes liées à notre consommation d''énergie).', 0.5);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (05d770ba-ae2f-44de-82e4-58cc17dc97d1, 2, 'Oui, pour le Scope 3 (toutes les émissions de GES indirectes liées à nos activités).', 1.5);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (da9a1200-884d-4ae8-8cc6-190dd8e45682, 3, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4eef3aa2-7758-4ab3-ada1-0ff8f8fb5f82, 1, 'Nous n''avons pas réalisé de rapport d''empreinte carbone.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (328619fe-26b8-4083-a271-66e2b042bd53, 2, 'Notre rapport d''empreinte carbone inclut une déclaration claire de notre engagement en faveur de la réduction de notre empreinte carbone.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e8bcede2-4520-42fd-9a8f-4e7d87ea5e73, 3, 'Notre rapport d''empreinte carbone présente une une ventilation des émissions de carbone par source ou catégorie.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (35fe40f1-3d70-4b8b-a84e-e0819c85112e, 4, 'Notre rapport d''empreinte carbone décrit de manière transparente la méthodologie utilisée, le champ d''application, le processus de collecte de données, les hypothèses, les incertitudes et les limites du calcul.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (47383c61-dbd2-423f-9eba-c40c654ae853, 5, 'Notre rapport d''empreinte carbone présente nos objectifs de réduction et décrit les mesures prises pour les atteindre.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (aa8f5394-3117-4717-bfa4-c11e60e98350, 6, 'Notre rapport d''empreinte carbone est conforme à la méthodologie Bilan Carbone® et/ou au GHG Protocol (il a été réalisé via un expert et/ou une plateforme agréé).', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (bde98f9a-3d31-4514-8cc9-f6e6068b138a, 7, 'Nous partageons publiquement notre rapport d''empreinte carbone complet (en ce compris tous les points cochés ci-dessus).', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (fa4cafad-fa5e-4c26-9998-4a307a4991c2, 8, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ebd08297-5ff8-4ac2-840d-bdae25845a82, 1, 'Nous incitons nos travailleur·euses à adopter des modes de transport plus durables pour se rendre au travail (marche, vélo, transports en commun, covoiturage, etc.) en mettant en place des mesures telles que l''installation de douches, des incitations financières, etc.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d76275f5-3cca-4689-b7cb-8df0845abe18, 2, 'Nous choisissons en priorité des fournisseurs qui adoptent les meilleures pratiques en matière de durabilité.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (385ef2aa-5eb9-410d-81a7-c13ee65f3897, 3, 'Nous avons une politique d''achats responsables, qui formalise notre engagement à privilégier les matières premières recyclées ou renouvelables et à réduire les déchets à la source.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (dc1291b8-13d8-45ec-9553-828ef64672ae, 4, 'Autre : veuillez expliquer dans les commentaires', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (3324dbfd-ff77-45dc-947f-2dc22c1e164a, 5, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (87e934e8-f261-4a3e-9ce8-39ba714fb885, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (822f82e3-163e-4e60-abb4-f595127ba190, 1, 'Oui', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (557c4411-5785-4cbb-bd7a-c83a6df0c764, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5694f27b-8110-4a62-b94c-16662836f66a, 3, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (fdd79aed-1f16-45fb-95c9-808179a130ca, 1, 'Je ne sais pas', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (53836e55-4cbc-48b7-8e74-e17347bdfbd4, 2, '<20%', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9cad1922-707b-4009-bd02-cd0d4dfe9ce5, 3, '20-39%', 0.2105263157894737);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0bd543ce-f73d-4d4d-8a95-582466d9beb3, 4, '40-59%', 0.3157894736842105);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c7b9cb9f-97d0-40c1-a8d8-f6ded4e62333, 5, '60%+', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4fc4809d-d43a-4dbf-98db-a382ce3423b6, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5329d5c0-520f-41e7-873f-16ea125a3487, 1, 'Je ne sais pas', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (10467bdf-2e0d-4d25-84d9-febcc88fc070, 2, '<10%', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (cfd37711-4d31-42c6-85fa-0f61b3de5a2c, 3, '10-39%', 0.1052631578947368);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (46699c68-e3b5-4002-ba02-3ac945796938, 4, '40-59%', 0.2105263157894737);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (476d1e63-6295-489a-8aa3-7f930ddb351b, 5, '60-89%', 0.3157894736842105);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (3cb4b5dd-340c-484e-9425-763d164e6931, 6, '90%+', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e5b0d930-5933-43d4-85f9-29eae853db6c, 7, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (17efcf1c-f31b-4202-81e0-9698fea805a1, 1, 'Oui', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (515290db-2624-4a21-aba0-92c3974406c7, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (fc778a77-90fd-4f81-80b3-3be948c12ff4, 3, 'Difficile à mettre en place en raison de contraintes propres à mon secteur.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a9e341c4-bd8e-437e-a23b-85aff5ecdcd6, 4, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (94cf2265-3f05-40c6-bc3e-bc678c77005d, 1, 'Nous intégrons des critères environnementaux dans nos contrats fournisseurs, afin de les inciter à adopter des pratiques durables.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e38278a7-9ed3-4666-abea-725cc158f5e6, 2, 'Nous réalisons régulièrement des audits environnementaux afin d''évaluer les performances environnementales de nos fournisseurs.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0c3c3ca7-3c1e-47ad-8459-50cdf07e75e4, 3, 'Nous procédons à des audits environnementaux réguliers afin d''évaluer les performances écologiques de nos fournisseurs.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (425ff650-398d-4525-9543-f772074e4035, 4, 'Nous incitons nos fournisseurs à opter pour des solutions de transport bas carbone pour la livraison des marchandises.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (95296474-6c05-4a66-b640-6b8b35a7770f, 5, 'Nous entretenons un dialogue ouvert avec nos fournisseurs et encourageons le partage des meilleures pratiques en matière de durabilité.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (169c3098-e569-4fc3-9dce-236c867b8d3a, 6, 'Nous travaillons en étroite collaboration avec les fournisseurs dès la phase de conception afin d''intégrer notamment les principes d''éco-conception, favorisant la durabilité et la recyclabilité.', 0.4210526315789473);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b6b6cf53-ae25-4c38-91ad-c093144aa1de, 7, 'Autre : veuillez expliquer dans les commentaires', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (6f71d88d-8c36-4813-8a59-3c0de728d039, 8, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (33d8ffc6-a8f1-4d3d-9b8f-43235026dddb, 9, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (6f1e2659-2cf2-4735-9eea-c1d792ac66ac, 1, 'Oui', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (1c27d6ff-8214-42e7-ab88-8e46aff8afc9, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ef0fc7f7-61c2-4b01-977b-6b78d38b3b59, 3, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a8ec73b9-8e1f-475a-8733-d13652a38a24, 1, 'Nous avons installé des appareils à faible débit et/ou économes en eau.', 0.8888888888888888);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5302a0ea-c318-4fd7-9907-b7e6b22c64fc, 2, 'Nous avons installé des systèmes de détection des fuites.', 0.8888888888888888);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b52035b9-adbd-46ce-9837-8757f2a058b7, 3, 'Nous avons mis en place des systèmes de récupération d''eau de pluie.', 0.8888888888888888);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f3c89deb-7985-4572-9e35-99dfb1a1f9b2, 4, 'Nous effectuons régulièrement des audits de notre consommation d''eau pour repérer les zones à forte consommation et les éventuelles inefficacités.', 0.8888888888888888);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (499ce711-d341-4f87-97e9-f230596c9789, 5, 'Nous avons établi des lignes directrices pour encourager une consommation responsable et rationnelle de l''eau.', 0.8888888888888888);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (02d0fc21-6358-4110-9ebb-7ecea9024293, 6, 'Autre : veuillez expliquer dans les commentaires', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e5d475fe-8e28-4f09-9b31-41ef508c1e14, 7, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (72978539-072b-4ebe-a3d9-b7717fac066f, 8, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (76884ba1-f3f9-44fb-bf57-d50e17e2c777, 1, 'Oui', 0.8888888888888888);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (bee3eb7e-ecc4-421b-874e-07e14ca73523, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c91c3575-c930-406f-afed-c7bd2410f7b5, 3, 'N/A - Nous n''avons pas de travailleur·euses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (30ad6320-8975-4016-98a5-09d7f056779d, 1, 'Nous avons réalisé une analyse de notre chaîne de valeur, incluant nos fournisseurs, services et matériaux, afin de repérer les principaux domaines où l''eau est utilisée.', 0.8888888888888888);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (58830c9b-b60c-445a-b602-1a9ac7bc5593, 2, 'Nous avons défini des objectifs pour réduire l''empreinte hydrique de notre chaîne d''approvisionnement.', 0.8888888888888888);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (08bffcc8-65fd-41b2-87db-89fa5be22cf7, 3, 'Nous collaborons avec nos fournisseurs et les encourageons à collecter des données et à publier leur empreinte hydrique.', 0.8888888888888888);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c64fed8d-4608-4cb3-ae8d-ec24fa228151, 4, 'Autre : veuillez expliquer dans les commentaires', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0c46d0f6-a0ca-4bf1-84d9-a570b2fb91d2, 5, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (823fd566-eaa7-4f8e-8d43-59605af3a150, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (68d8fb45-5403-4c9c-91f6-721001b760da, 1, 'Nous avons effectué une étude approfondie de nos produits dans le but d''identifier les opportunités d''amélioration dans l''utilisation des ressources (exemple : analyse de cycle de vie).', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a1b19035-af49-4dd6-afe3-21067df825c0, 2, 'Nous investissons dans des technologies et des pratiques plus économes en ressources, et explorons de nouvelles possibilités de réduire l''utilisation des ressources.', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (78250b0e-d9c6-4b41-8c2e-961baf6d610c, 3, 'Nous partageons de manière transparente l''origine et notre utilisation de matières premières et/ou de nos fournitures.', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (6ac30a7d-de85-4f99-a88d-05c49efb9fcd, 4, 'Autre : veuillez expliquer dans les commentaires', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (eeb1bf1b-74dc-4bb8-8545-544714d2ccbe, 5, 'Aucune des réponses ci-dessous.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (58278cc5-07cb-4562-bfbd-234cb1103908, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e534d8e3-11af-4485-8270-b0184a398256, 1, 'Oui', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9f3fa84a-4554-48a9-99e7-4be05c01f781, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2766494e-222c-4257-afa8-180b96e402c6, 3, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2dbf24c3-9e6d-4898-bc63-762cb2d394fb, 1, 'Je ne sais pas', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b5dee924-e1c4-466b-b3a3-ca5ee95ca475, 2, '< 20%', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c110f833-2307-4a5a-a625-e198f5599e26, 3, '20-49%', 0.5);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (722b8fbd-97e0-45fa-870f-9d39d7d582e7, 4, '50-74%', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (8a35b1be-40b9-4d67-a780-888d36171a9e, 5, '75-99%', 1.5);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (136c8c8f-b7a4-46b5-a6e0-5d2d23ed0676, 6, '1', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a767aa00-1ace-43b2-9243-ff12bc10365c, 7, 'N/A - Cette question n''est pas pertinente pour mon activité', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d066938f-3c5f-46fa-8390-2ce47699fd16, 1, 'Oui', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (20ba2465-23d7-41a7-b548-6d05a6f9cefc, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a8dc7a95-c4de-4fe2-808f-d85c8cd9de18, 3, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (933add90-8169-481d-8b78-a22dd455f809, 1, 'Nous avons des programmes de recyclage couvrant au minimum le papier et le carton, les PMC, le verre et les déchets organiques.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (229446af-f6aa-4671-bcc9-9080c8cddc5d, 2, 'Nous avons identifier au sein de l''organisation une personne responsable de la gestion des déchets (réduction, tri et éliminiation).', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0af33ac1-987f-4cd6-8a9f-4d012b08ebf0, 3, 'Nous mettons en place des systèmes efficaces de collecte pour les matériaux recyclables, en partenariat avec des fournisseurs spécialisés dans le recyclage.', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0e203cb2-1017-4302-a281-4ef62da57888, 4, 'Nous avons établi des lignes directrices pour l''élimination responsable des déchets qui ne peuvent être recyclés ou récupérés, en veillant au respect des réglementations et des normes applicables en matière d''élimination des déchets.', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (78c5dcbc-3a5b-4306-8569-207023ee1758, 5, 'Nous mettons à disposition des articles réutilisables, tels que des tasses, des verres et des ustensiles, pour réduire l''usage de plastique jetable.', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (94864be8-eedb-4ed3-b4bc-1991af9feab4, 6, 'Nous privilégions l''achat de produits et de fournitures de bureau en vrac ou avec un emballage réduit au minimum, afin de limiter les déchets d''emballage.', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (1efc6428-3967-4e45-8499-ad47bf317d07, 7, 'Nous favorisons l''achat de produits rechargeables, comme les cartouches d''encre et les piles, afin de limiter notre production de déchets.', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c4716590-a5cc-4176-a31d-5d9bd8ca0bf8, 8, 'Nous privilégions les options de don ou de réutilisation, plutôt que de jeter, pour des articles tels que les meubles ou les équipements.', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (57f839b3-8ed8-4482-a5c5-9ae80f4da5ba, 9, 'Autre : veuillez expliquer dans les commentaires', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b81a7c03-c341-459a-86c3-84dfd3f1f014, 10, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (296129cd-3ffb-4a32-8386-e1eb880551ff, 11, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c9e9f953-4660-4c45-86e8-97ca713e653b, 1, 'Oui', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0f6aea36-ab94-4a66-af11-4488b6c6b102, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (39ed4d65-a681-48e8-88a8-430b35fef5cc, 3, 'N/A - Nous n''avons pas de travailleur·euses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e656d3cf-a802-4f81-bb96-4cc6451f0882, 1, 'Nous réutilisons les déchets générés au cours des processus de fabrication.', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (1337cfe8-8f34-43bd-9552-b2d8c5b6a2ba, 2, 'Nous avons pris des mesures pour simplifier le recyclage ou la réutilisation de nos produits.', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (480840a1-655d-41df-a843-634b77344345, 3, 'Nous disposons de programmes de reprise des produits en fin de vie.', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (86cb0beb-cd0d-4173-9a77-78514c4c8836, 4, 'Nous réalisons régulièrement des audits de notre production de déchets pour repérer les principales sources, les possibilités d''amélioration et les opportunités de réduction.', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ee4bed01-ab0e-4478-94f7-900ef92c05d7, 5, 'Nous sensibilisons les travailleur·euses et/ou les consommateur·rices aux principes et aux avantages de l''économie circulaire. ', 0.6153846153846154);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0acbc811-a96b-4a59-b4f1-7dbc9c53c810, 6, 'Autre : veuillez expliquer dans les commentaires', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2dd049de-b57a-48c1-8694-efbca7091b36, 7, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (fb2c2f93-7238-4511-9b65-6f2e6b14cd7d, 8, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (29aad371-5f9c-465c-b8b8-67cc0b0ef792, 1, 'Nous avons réalisé une analyse des impacts potentiels de nos activités sur la biodiversité.', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9888f570-3b97-42a4-be11-7ca5159516b2, 2, 'Nous avons mis en place des actions pour préserver et améliorer la biodiversité (comme la plantation d’arbres, de végétaux locaux ou la création de refuges pour la faune).', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (8aa8b0fa-702b-4c94-ae91-dc1efdd5b46b, 3, 'Nous avons créé ou restauré des espaces naturels (par exemple, en réaménageant des zones dégradées ou en favorisant la végétation locale).', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4044d1e3-9063-4b43-866a-a4fb6071d5f1, 4, 'Nous limitons fortement l’utilisation de produits nocifs pour la biodiversité (tels que les pesticides ou les engrais chimiques).', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (48356442-dac3-437c-a36b-0f977224cefb, 5, 'Nous veillons à une gestion responsable et durable des terres (en réduisant les impacts liés à l’aménagement ou à l’exploitation et en préservant la qualité des sols).', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (de162c52-7f1e-477a-98c8-af786193ab25, 6, 'Nous avons formalisé notre engagement envers la protection des écosystèmes et de la biodiversité.', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (127fe6c6-093d-42db-83e3-a859c6c95a52, 7, 'Autre : veuillez expliquer dans les commentaires', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (7e998081-973d-4309-86b0-353832132f9c, 8, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (043ab984-1c7d-4f99-84a5-a9f85a6593a4, 9, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b5506fd2-527a-413c-932e-e821f48ada33, 1, 'Oui', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (dd1b1c61-9761-497c-a755-4875d668fca3, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2186b15c-15b4-4e38-82a2-8e30798fbbbb, 3, 'N/A - Nous n''avons pas de travailleur·euses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (870f0f43-2cff-4657-8c31-1d60e3446ba5, 1, 'Nous incluons dans toutes nos offres d''emploi une déclaration d''engagement en faveur de la diversité, de l''équité et de l''inclusion.', 0.7272727272727273);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ff0beb26-d391-4e67-93c4-bfea26cba54a, 2, 'Nous analysons la formulation et les exigences de nos descriptions de poste pour nous assurer qu''elles sont inclusives et équitables.', 0.7272727272727273);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (64703b06-9147-4640-a74c-5811a70ec253, 3, 'Nous recrutons activement par l''intermédiaire d''organisations ou de services qui s''adressent à des personnes souvent exclues du marché du travail (ex : personnes en situation de handicap, personnes qui ont été incarcérées, demandeurs d''emploi jeunes ou de longue durée, etc.)', 0.7272727272727273);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a90115eb-157a-4b9d-9836-33a60a95c4cb, 4, 'Nous procédons à des examens anonymes ou "à l''aveugle" des candidatures ou des CV sans y associer de noms ou de caractéristiques identifiables.', 0.7272727272727273);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (80c3ce15-545f-4b20-9e52-85c88ce9e73e, 5, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f071ce0f-01b8-4670-9cad-12e941fde029, 6, 'Rien de tout cela.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (494a03d4-2cc1-46d3-ac28-e7e50ccb2c98, 7, 'N/A - Nous n''avons jamais recruté.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e26a67f7-8a2a-463c-b144-b093ed70960c, 1, 'Nous avons désigné une personne ou un groupe explicitement responsable de la diversité, de l''équité et de l''inclusion.', 0.7272727272727273);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (8f8032c3-35bf-43c2-82c2-ca8b5eb2c91a, 2, 'Nous proposons des formations à tous·tes les travailleur·euses sur des sujets liés à la diversité, à l''équité et à l''inclusion.', 0.7272727272727273);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5de05c4a-cca2-4d17-ae56-a413ac687084, 3, 'Nos installations sont conçues pour répondre aux exigences d''accessibilité pour les personnes souffrant d''un handicap physique.', 0.7272727272727273);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (086045f2-42bf-4a0b-9f64-1e352fb83127, 4, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (911775fe-4b52-4b4a-953b-50a6215ed173, 5, 'Rien de tout cela.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9d38e811-974a-45a6-a581-b99453597148, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (014539db-1951-467c-8cd1-8f6149a2f716, 1, 'Une affirmation claire et explicite de l’engagement de l’organisation envers la non-discrimination et l’égalité de traitement pour tous·tes, indépendamment de l’origine, de l’ethnie, du genre, de l’orientation sexuelle, du handicap, de l’âge, de la religion ou de toute autre considération qui limiterait l''inclusion et l''équité.', 0.7272727272727273);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (372fd934-7993-4c09-9a16-f2ba4a9a8a5b, 2, 'Identification des rôles et des responsabilités pour établir un lieu de travail inclusif et créer l''implication de tous·tes à tous les niveaux.', 0.7272727272727273);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b3cd65cf-291d-4746-9852-4f9c4e8657ba, 3, 'Mise en œuvre de programmes visant à sensibiliser les travailleur·euses aux biais inconscients, à renforcer leurs compétences culturelles et à promouvoir des comportements inclusifs pour une culture d’inclusion active. ', 0.7272727272727273);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (53a6abd9-f6cc-4339-a79a-8d2e77617195, 4, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (dfe6d0a5-b96d-40d1-b26c-84fdc9c037b3, 5, 'Rien de tout cela.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (7804e07b-7936-4fe7-a03a-5ab3b1cf91fc, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e057055f-e848-4f87-a190-b3ae89078b9d, 1, 'OuI, nous nous assurons que chaque travailleur·euse ait suivi une formation sur la diversité et l''inclusion.', 0.2857142857142857);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c66b146f-1b2c-448f-8140-d5d0f2357127, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b198dc9c-4835-4f33-a18f-e7c7b6b51d33, 3, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (142ea78c-7a7d-417e-9e3f-16c5831f9748, 1, 'Oui', 0.7272727272727273);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a9e4544e-6023-4a99-aee5-9edc97721604, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (bcea2bdc-e326-44ae-96eb-a50be1556784, 3, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0aab81d2-8e08-4a05-988c-82ca6243dd70, 1, 'Je ne sais pas.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (31003cbd-c32a-42fc-b677-20d39305fda6, 2, '>15x plus élevé', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e7a78612-9d29-4682-8439-0ad5dc96a033, 3, '11-15x plus élevé', 0.1428571428571428);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (3d59dbb5-29d8-4742-90e2-bd712848f7a4, 4, '6-10x plus élevé', 0.2142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (07d7616d-d307-4569-8c30-10e080657c27, 5, '1-5x plus élevé', 0.2857142857142857);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b219d4f6-ffd6-4a3c-9222-6129082b9673, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (885e0b68-d28b-4488-b365-4fb9e378d30c, 1, '0', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (aec36d07-0d1a-4cee-9c9b-73a6f6ba63d1, 2, '1-14%', 0.1428571428571428);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5e0a2f4a-9a34-4f56-a2b3-6cb7a47de688, 3, '15-29%', 0.2142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (6759e720-16ff-4fa9-9379-31748556ccf5, 4, '30%+', 0.2857142857142857);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (10f357e8-c852-4fae-87b1-83dc17299122, 5, 'Je ne sais pas.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d9547360-6109-47d2-9cd5-6e7934e6ad0f, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (00eacc52-bfd1-4876-b9f8-7e60fa596671, 1, '0', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (369f224e-69ff-4d47-a701-01a52644b2da, 2, '1-24%', 0.1428571428571428);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a0ecb747-0b86-465f-98f1-1c97b91092d5, 3, '25-49%', 0.2142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (568b1a86-d1f2-481b-ba93-a5f0faa96f3c, 4, '50%+', 0.2857142857142857);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4bed4e3f-aa51-4ca9-9c04-1496b3cd98bc, 5, 'Je ne sais pas.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c452a43f-db5a-4d83-969f-d67a339ecce1, 6, 'N/A - Nous n''avons pas de cadre.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (63f70cb7-091a-46ef-b1f6-5d50d2176524, 1, '0', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f70dd594-7793-4d73-a11c-be8720ba6ce5, 2, '1-24%', 0.1428571428571428);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d239aa43-6ab9-4790-b8ea-04560d45d9f8, 3, '25-49%', 0.2142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2b5627d1-c804-48f8-a5ed-dc7d21b9f8cb, 4, '50%+', 0.2857142857142857);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c3efec7a-7777-412c-a0af-7873a2cb4b13, 5, 'Je ne sais pas.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (adeda856-a159-4066-a9ec-18d3cd1547e1, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9a888fa4-a99f-49e0-a799-85e5aa177240, 1, '0', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5955e3bd-eb6f-429e-9116-cb518eeadd4c, 2, '1-14%', 0.1428571428571428);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f04401c5-7360-4560-9d09-391baaf41d6f, 3, '15-29%', 0.2142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (fbc29b8b-0fdc-425f-8063-a05ed59ecebc, 4, '30%+', 0.2857142857142857);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (3e021908-5d8a-4041-916a-ba90e299ee37, 5, 'Je ne sais pas.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (552cb038-43e1-48f2-9112-98b33f361bec, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (8149b742-d1e9-41a2-b344-ba2c132b843f, 1, '0', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (dc41d619-eb3c-4240-9573-0f64862f8b09, 2, '1-14%', 0.1428571428571428);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (147c5488-a252-448c-bbfc-14d42342c02f, 3, '15-29%', 0.2142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (764e7eae-d591-4e28-bd5d-7f9716a692db, 4, '30%+', 0.2857142857142857);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0d2d5bec-77f8-4f93-bfb7-c4dfa702a4fc, 5, 'Je ne sais pas.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2d61b872-c4a2-4bb8-ac18-d4298b107978, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (dcfb662c-4faf-4192-9667-a778a8b89b00, 1, 'Nous élaborons et communiquons des politiques claires en matière de sécurité, facilement accessibles.', 1.428571428571429);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (83ae841d-7bcb-4b8d-b0eb-eaad9fa8514f, 2, 'Nous élaborons et communiquons des politiques claires de lutte contre le harcèlement et la violence, décrivant les comportements inacceptables et les conséquences en cas d''infraction.', 1.428571428571429);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (815ee6fe-696d-4618-beb0-f5f801954552, 3, 'Nous mettons en place en place des systèmes de signalement confidentiels et anonymes permettant aux travailleur·euses de signaler les incidents de harcèlement ou de violence sans crainte de représailles.', 1.428571428571429);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (bbfd69ee-bd9a-4803-b23c-cdd2f3602f93, 4, 'Nous définissons et communiquons des procédures claires pour l''examen des plaintes, en veillant à ce que les enquêtes soient approfondies et impartiales.', 1.428571428571429);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9a415769-a308-4023-948a-a024520d0869, 5, 'Nous mettons en œuvre des programmes de formation annuels pour apprendre aux travailleur·euses à reconnaître et à prévenir le harcèlement, la violence ou les comportements dangereux sur le lieu de travail.', 1.428571428571429);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (41569aec-6a95-4c25-bd5f-2e0b3239bf09, 6, 'Nous mettons à jour nos politiques de lutte contre le harcèlement et de gestion des plaintes et des incidents chaque année, et nous informons les travailleur·euses des ressources disponibles à cet égard.', 1.428571428571429);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4137dc22-2b01-4b59-999e-478b0bff12eb, 7, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f951fadd-8c7d-4a54-bc81-5a88723c3ba9, 8, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (57e9eefd-b5c0-4b6c-a462-2f340081a933, 9, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a4843c21-d4e8-4348-b3d7-b5886917992f, 1, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9009203e-fd47-4da0-9653-dfeefa281f2d, 2, 'Oui : ', 1.428571428571429);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (92923ebe-0254-45d5-9ea3-37b2ff2263ce, 3, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a03db7ad-cd6f-43c3-b8ab-5d8e65d17616, 1, 'Nous fournissons aux travailleur·euses des services de conseil en matière de santé comportementale, des ressources en ligne ou des programmes de soutien en matière de bien-être au travail.', 1.666666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (94fd30e7-1c22-4083-8be9-28cd762a84f1, 2, 'Nous avons mis en place des politiques et des programmes visant à promouvoir la santé et le bien-être sur le lieu de travail.', 1.666666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (760dff3f-fe64-4cf9-b38d-5784204ecc89, 3, 'Nous parrainons et encourageons les travailleur·euses à participer à des activités de santé et de bien-être pendant la semaine de travail (par exemple, des programmes de marche ou d''escalade).', 1.666666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c087b555-da9d-4ae8-b355-c3506fd4e62a, 4, 'Nous invitons les travailleur·euses à effectuer des évaluations des risques pour la santé ou à participer à des activités de santé et de bien-être (par exemple un abonnement subventionné à une salle de sport).', 1.666666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5b268e93-4414-4bd4-bee0-6cdb2892bbdf, 5, 'Plus de 25 % des travailleur·euses ont effectué une évaluation des risques pour la santé au cours des douze derniers mois.', 1.666666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (62ae8b15-7457-4f99-8ef0-53fa059a3824, 6, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c0a66a03-3d30-42a0-abef-346c7cbf84b7, 7, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e1a9c265-022c-4362-ac66-9a2c471793ae, 8, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (7d9fe843-d095-4a51-8941-6e8d23fa58b8, 1, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f9ecf797-42dc-4da0-a9f0-e94a12d96bf9, 2, 'Oui : ', 1.666666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a0ee0c0a-1ecf-4197-a875-698c2250670b, 3, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ff2a5f02-e23f-40ce-ba7b-014ac42a7afc, 1, 'Oui, nous avons un plan de formation.', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9b9d77fb-a36e-401e-b4b5-1eba339e01cb, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b1322563-4ee4-4082-ada7-94c2914fed70, 3, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (1fe6ce51-f0e4-4f5e-a881-add3191a91f7, 1, 'Nous disposons d''un processus formel d''intégration des nouveaux·elles travailleur·euses.', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a5e08abb-f96f-4620-a677-73583acc01c0, 2, 'Nous encourageons les promotions internes et l''embauche pour des postes avancés (en publiant d''abord les offres d''emploi en interne).', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a3ca5111-0dc2-4af7-b8ea-a3f4c5c4c2c7, 3, 'Nous proposons des formations polyvalentes pour les avancements de carrière ou les transitions (par exemple, une formation en gestion pour les non-cadres).', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5855962b-20c8-4d86-9314-71f1f95d5ec9, 4, 'Nous facilitons les opportunités de développement professionnel externe et disposons d''un budget à cet effet (participation à des conférences, formations en ligne, etc.)', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9c750739-63f8-4f3a-8133-d1991891223e, 5, 'Nous offrons des remboursements ou des programmes pour des formations continues certifiantes (par exemple, diplômes universitaires, licences professionnelles).', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c79ccd55-2ab9-425e-a160-6e2ef47fd4b4, 6, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b5828eb9-97c5-49d4-b545-71fa9b62b2e9, 7, 'Rien de tout cela.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (35db326b-5663-411b-aa8f-84c12ff6e79e, 8, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (6300bbb4-9821-48dc-b7a8-7074e8d371ac, 1, '0', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (84e9be6e-e68e-460a-8d0d-0e3f717b570d, 2, '1-49%', 0.1666666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (62836608-dacf-4fc3-84e2-f2321cbe0a30, 3, '50-62%', 0.3333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a5754cc3-33a0-4b11-9a46-175fc446d4d6, 4, '63-75%', 0.5);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (cca40e55-41b5-487c-ab0a-b8b6122c88e0, 5, '>75%', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d01218bd-6bb0-485a-91b7-9e4261b665f5, 6, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (eb43370d-336a-43c7-9518-4a9d8679f852, 7, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (146757be-f555-48a1-b29f-5d58f05d8368, 1, '0', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (74489f62-b857-4b5f-ae7f-17820adcfa60, 2, 'Le montant suivant : ', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (6cf642c6-6c84-49ff-975a-aae96d3b3030, 3, 'nan', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5a42f4d5-26db-4ddb-a610-5323ffc436c7, 1, '0', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2e193642-1997-4627-b51c-2a937fd7be55, 2, '1-4%', 0.3333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (29431a76-cc0f-4f62-96dc-b4ead485f334, 3, '5-14%', 0.5);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (8042fd6c-11fc-4e4e-9649-a150ae534c77, 4, '15%+', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (86084bb9-7f9f-4857-b1ed-177588ff6025, 5, 'Je ne sais pas.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (738d5593-0043-4cc4-b483-138282b98066, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (14175aad-a5e8-4b03-8ca3-328178ecc22e, 1, 'Nous avons mis en place des processus permettant aux travailleur·euses de donner leur avis et de contribuer aux prises de décisions opérationnelles importantes et/ou stratégiques et/ou sur tout changement de pratique qui affecterait leurs habitudes de travail (exemples : team et management meetings).', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (67af852f-3231-456a-8809-eaed7f34795b, 2, 'Nous disposons de mécanismes formels de retour d''information pour répondre aux préoccupations et améliorer les pratiques de l''entreprise (retour sur les préoccupations et contributions).', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e374e087-aaf3-4643-b949-a45c37d4f7e9, 3, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c4262b1a-bd15-4240-80cb-4694bb35ce10, 4, 'Rien de tout cela.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (96e96eba-296f-462c-b547-f4c777f83260, 5, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e15cc1d7-0e62-4840-b6f1-47b30e823bc4, 1, 'L''entreprise contrôle la satisfaction des travailleur·euses.', 1.111111111111111);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c5b0b248-16d4-475f-9e05-6acbc4706803, 2, 'L''entreprise partage la satisfaction des travailleur·euses en interne.', 1.111111111111111);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (8c041d17-d6be-494f-ad42-ad79215e766d, 3, 'L''entreprise partage la satisfaction des travailleur·euses publiquement.', 1.111111111111111);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0792e5af-ef92-45a9-a442-f13a397bad08, 4, 'L''entreprise a défini des objectifs en matière de satisfaction des travailleur·euses.', 1.111111111111111);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (cca23c4a-4a46-4b1c-b985-60f583a8d385, 5, 'Au cours de l''année écoulée, l''entreprise a atteint les objectifs fixés en matière de satisfaction des travailleur·euses.', 1.111111111111111);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (00afa007-844b-4715-bb3e-c2fa0a97820e, 6, 'Rien de tout cela.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (856fdd6a-4835-4763-86e9-22f54afbe119, 7, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9aa60d3c-e0f5-4afd-aa0a-689554774c57, 1, 'Pas de versement de bonus ou pas de plan de bonus.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (59630b68-0c64-4568-aba7-5f608ee8109c, 2, '<1%', 0.2777777777777778);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (350224be-5866-4cee-9f90-e46272e920a3, 3, '1-2%', 0.5555555555555556);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (7580c94d-7d17-4181-97e6-25aa714a6bd4, 4, '2-3%', 0.8333333333333334);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9849b4ab-fc15-4bfd-aebb-36868ed4e7b6, 5, '>3%', 1.111111111111111);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c1b5a28f-71ef-41f5-8590-973825f7d61b, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (bc7e4212-de21-4bdd-8b70-ae5fd7b07781, 1, '0', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (eefd2d44-364a-4a28-8d55-e2a9552a1d49, 2, '1-49%', 0.2777777777777778);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4fc6613e-9361-4d0e-8601-d44d6055d69a, 3, '50-62%', 0.5555555555555556);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (545a2b74-dd91-41f4-9d7f-005a8b05e418, 4, '63-75%', 0.8333333333333334);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (855c75f8-cc6a-41b7-aed5-cb1d7d85840d, 5, '>75%', 1.111111111111111);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f13e9661-d8eb-4dba-98d9-0e2368eb9edf, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f2954ff4-74ac-455c-9073-43c631dcba45, 1, '<65%', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (bfee3894-1008-4b04-a6b8-796a06a3539c, 2, '65-80%', 0.5555555555555556);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (470f70b4-0e54-47ec-b7b1-5607719663c7, 3, '81-90%', 0.8333333333333334);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0e786898-ed7e-4d58-8b10-6ebd50553754, 4, '90%+', 1.111111111111111);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (660cc076-d615-4fb7-b9e5-340e5bc06f96, 5, 'Je ne sais pas.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2274e087-518d-4ee2-9003-dc894e45647b, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (30fe1e28-8a0b-46e3-a237-c277e5ca2264, 1, '<5%', 1.111111111111111);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c38e291b-a598-4e42-93e8-675c5e8a93a3, 2, '<12%', 0.8333333333333334);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0ce67dd2-ad0a-4ef2-9fae-8fc0fd96d184, 3, '<25%', 0.5555555555555556);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (690eb42d-0d49-489c-86b1-20c83b87f144, 4, '<40%', 0.2777777777777778);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (7c77b5f3-239f-4ae8-bd6c-1ab6a5fbc853, 5, '40%+', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (82995f14-8200-4926-a197-53607a983f6b, 6, 'Je ne sais pas.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (81701791-842e-4eb4-91b4-239e183966b4, 7, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5ffcc391-797e-408d-8f88-45ce65cdc8ee, 1, 'Nous avons des partenariats avec des organisations caritatives.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b59f7ab4-87c6-4cae-a0ce-a8bda11b3151, 2, 'Nous offrons des produits ou des services à prix réduit aux groupes défavorisés.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4f12d52c-264f-47ba-883b-f7947ec56f26, 3, 'Nous nous engageons dans des projets innovants au sein de notre communauté afin de résoudre des problèmes tels que la pauvreté, l''inégalité et la durabilité environnementale.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (49ed51f7-405d-4042-938f-408f1228b8e2, 4, 'Nous investissons dans des projets d''entreprenariat social qui cherchent à relever des défis sociaux grâce à des modèles d''entreprise durables, ou nous les soutenons.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2258b6aa-281d-4238-bd01-0993c826fd23, 5, 'Nous participons aux efforts de sensibilisation et nous nous engageons auprès des décideur·euses politiques pour aborder les problèmes systémiques et contribuer aux changements politiques.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (005ffad4-20dc-46e4-a589-71c16ff23b57, 6, 'Nous collaborons avec des ONG et des fondations établies pour soutenir des projets sociaux, en tirant parti de leur expertise et de leurs réseaux pour un plus grand impact.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c69f3f93-c9b2-4797-8d99-0dbb8007925f, 7, 'Nous encourageons l''engagement social de nos travailleur·euses (par exemple en offrant du temps rémunéré pour le bénévolat ou en organisant des journées de teambuilding dédiées à des projets solidaires).', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (57979047-dd97-4d8e-8143-4a1875b1a0aa, 8, 'Autre, veuillez décrire dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2e400588-783a-4859-88d5-d5ab48dcf37e, 9, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0b989d85-8cb9-4d70-8e18-c00dcc56c209, 10, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (3748f987-a894-43f6-90c0-99c48d97f262, 1, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ecf6e3ea-38a2-4679-accf-3dbf5daacf60, 2, 'Oui : veuillez indiquer le nombre d''heures', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a585ff7b-f443-4da6-baf6-be1ae437b257, 3, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4566b9a8-fffe-4013-8b5a-7dc729c7e453, 1, 'Nous établissons des partenariats avec des organisations caritatives et sans but lucratif locales afin de leur apporter un soutien financier régulier, garantissant ainsi un impact positif constant sur la communauté locale.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (8b9927b3-0ea1-490b-8da3-aa9c9c816113, 2, 'Nous mettons en place un programme de jumelage des dons des travailleur·euses où l''entreprise égale les contributions des travailleur·euses aux œuvres de bienfaisance locales, doublant ainsi efficacement l''impact.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (1b1c7114-04a9-4280-acc1-c70256e3e667, 3, 'Nous contribuons à l''enrichissement des arts et de la culture locaux en soutenant, par des dons financiers, des théâtres, des musées ou des manifestations artistiques de la communauté.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (76729c90-a4d6-4100-b182-46d882179be9, 4, 'Nous allouons des fonds à des projets d''aide humanitaire mondiale, en soutenant les efforts de secours dans les régions touchées par des catastrophes naturelles, des conflits ou des crises sanitaires.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (383f70b7-df1e-4403-8a16-525d79d77e3c, 5, 'Nous mettons en place un programme de subventions pour soutenir des projets consacrés à la conservation de l''environnement, aux pratiques durables et à la préservation de la biodiversité.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b15e91f3-9589-4027-a997-8e559ad92a12, 6, 'Nous soutenons des initiatives mondiales en matière d''éducation en faisant des dons à des organisations qui s''efforcent d''améliorer l''accès à une éducation de qualité dans les communautés défavorisées.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (7b631279-c5cd-4204-845e-d372b39bd17b, 7, 'Nous allouons des fonds pour soutenir des initiatives de microfinance, permettant à des personnes dans les régions en développement de créer ou de développer de petites entreprises.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d6fb00cc-f0c4-4df8-ad0a-58fe5730e502, 8, 'Nous contribuons à des organisations et à des projets consacrés à la défense des droits de l''homme, en abordant des app.questions telles que l''égalité des sexes, la justice raciale et l''équité sociale.', 0.5333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9fe34371-f744-4856-bf25-98860608b30f, 9, 'Autre, veuillez décrire dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4dd0e0cd-b343-4ce2-832e-4e8ce0902511, 10, 'Aucune des réponses ci-dessus.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (1903faa6-0a7f-49a9-8d00-00e6d990c3a3, 11, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (25754890-9c66-499b-aac9-f846b13b52c9, 1, '<1%', 0.5);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ef6ffb32-d1f1-46d5-b651-7e2666d30fef, 2, '1-2%', 0.7);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (421f8f53-d6fd-4d70-afa8-7fb21963780d, 3, '>2%', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (49f0549a-c307-41de-91c2-83fbc58dbb2a, 4, 'Pas de philantropie', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c392b0b7-5050-480b-b9ba-befdac64fcfc, 5, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9f088963-bbe9-4eba-9cfe-664a2e425617, 1, 'Notre organisation est dirigée par ses fondateur·trices ou propriétaires uniquement.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (17dc62fb-5f35-485e-9ff9-c3fde43bf9fe, 2, 'Notre conseil d''administration est composé d''au moins un·e membre qui n''est pas un·e fondateur·trice ou un·e propriétaire de l''entreprise.', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (8fe86a51-3a67-47bd-8365-62e0281ec9ab, 3, 'Notre conseil d''administration est composé d''au moins un·e membre représentant les travailleur·euses de l''entreprise.', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2e23e295-9ac7-4090-9898-a8353b505355, 1, 'Les travailleur·euses cadres et/ou non-cadres.', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (837ab0d7-6b53-4fee-b612-ffcdccf4ec05, 2, 'Une expertise locale et/ou sociale. Par exemple un·e représentant·e de parties prenantes stragégiques, d''une université locale, d''une organisation territoriale ou sans but lucratif.', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (bb19d364-d675-4b6e-99b6-36327fef729a, 3, 'Une expertise environnementale. Par exemple un·e expert·e en développement durable, un·e  expert·e scientifique, une organisation territoriale ou sans but lucratif.', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ef092b89-89e8-4512-8d9a-2c83481895d4, 4, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ab1e42bb-5101-49c5-a35f-316de22ab19f, 5, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (77fd4e98-aad6-4946-8839-ef7f0607a05d, 1, '0', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (51c92d1b-c0cc-4eb6-9e56-1cd6abc95046, 2, '1-24%', 0.4);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (bd3732ed-6d53-45ba-abc5-d9e609548d20, 3, '25-49%', 1.2);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a56fc416-726e-4de4-be49-e3e503dfc9f9, 4, '>50%', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c8fcc7d2-4b78-4e81-9899-aea8e4bdd32b, 5, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (49853385-4ad7-489a-8c0b-3c729b1bf01a, 1, 'Oui', 1.333333333333333);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (96ea6bc5-70a2-4d70-9c56-623dd1e6331f, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (fdc08d4d-5905-4359-80cc-304ad695c96b, 3, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (35b1e15f-8ae3-4164-b309-d9276c7ab54a, 1, '1-24%', 0.5);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (7c96fdaa-fcdc-41ec-a815-5792079e752d, 2, '25-49%', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (1cf627e5-4afe-47af-8f67-48e636c6782a, 3, '50-75%', 1.5);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (aa4636e8-a4aa-43bb-bce4-2f160fe8d8de, 4, '>75%', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (74a2d8ab-4c36-4e5a-89dd-a8c9589654b2, 5, 'Nous ne procédons à aucun contrôle ou audit de nos fournisseurs.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (52967aa4-9eda-434d-8123-dbb06e0cac1c, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (af8fcabf-b52b-43d3-adb4-4b4bb7fb5cc1, 1, 'Nous intégrons des critères ESG dans la sélection des fournisseurs.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (cf53b90d-9362-4f2d-a239-1a337e836bd6, 2, 'Nous intégrons des clauses ESG dans les contrats avec nos fournisseurs.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ebd4b40e-ef18-4294-aa16-0753c70c83c2, 3, 'Nous collaborons avec avec nos fournisseurs pour améliorer leurs pratiques ESG.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5167947e-21b4-447b-8309-c27b63c80fde, 4, 'Nous encourageons nos fournisseurs à faire preuve de transparence et à divulguer leurs performances en matière d''ESG.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (cc25a4fe-5d70-49ef-b239-86fc3bd57d1a, 5, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (3f62ebbe-dbc0-4c0c-bd75-d6fd65d1674c, 6, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (3b304b5c-d1fd-4409-a05d-10f52565d6a6, 7, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2bac05d8-f133-4128-b7b8-3183d7d975d6, 1, 'Nous proposons des garanties sur nos produits et services, ainsi que des politiques de protection adaptées.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (567c3a3e-3320-49ff-9916-f25bf45fe7a9, 2, 'Nous disposons d''une ou plusieurs certifications de qualité ou d''accréditations de tiers attestant de la qualité de nos produits ou services.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (20311970-e230-4305-af0f-37762d5e1d9f, 3, 'Nous avons mis en place des mécanismes formels assurant un contrôle rigoureux de la qualité de nos produits ou services.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (746095c1-ce8e-454c-a9b4-4068ab812b0f, 4, 'Nous avons mis en place des mécanismes pour recueillir les retours d''information, gérer le service après-vente et traiter les réclamations.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c99cc8bd-32fb-45c8-b5f5-2d051a397c9d, 5, 'Nous contrôlons la satisfaction des client·es ou des consommateur·rices.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e3fd9036-ef8b-498b-a929-f3eb5d366392, 6, 'L''entreprise offre une assistance en temps réel à ses client·es.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (72dda6bd-c0fb-4179-8152-9601020db592, 7, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (fe55add1-7cde-4e08-a841-f3dcc6d6b127, 8, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (94974c61-cea4-4f74-95fd-8026dc152050, 9, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (347f31d3-c2b9-4cb7-a086-1fe6a01ea8b9, 1, 'Nous formons et sensibilisons nos dirigeant·es et travailleur·euses aux app.questions sociales et/ou environnementales importantes pour notre entreprise ou notre mission.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (3fe6de76-5be2-4794-b21e-7b4d502fd1fc, 2, 'Nous intégrons explicitement les performances sociales et environnementales dans les descriptions de poste des cadres.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (927938f8-6d7a-407c-b419-d5562fef3dca, 3, 'Nous incluons formellement les app.questions sociales et environnementales dans nos évaluations des performances.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (8a6b1be4-2064-4daf-a9bb-899de64c2a95, 4, 'Nous examinons, au sein du conseil d''administration, les performances sociales et environnementales.', 0.5714285714285714);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (08901678-d660-49be-b16c-2cdc9f1057e1, 5, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b78aaf16-353e-4c21-b8fb-e89e79c9007f, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (45113974-f9f0-48b1-ad4d-200fa3065afe, 1, 'Aucun engagement social ou environnemental.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (51c61beb-09d0-4e47-bf84-2e5b5de8c9a1, 2, 'Un engagement général en matière de responsabilité sociale ou environnementale (par exemple, préservation de l''environnement).', 1.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (543002e0-c307-4225-af85-077601a92782, 3, 'Un engagement en faveur d''un impact social positif spécifique (par exemple, politique de prix réduit pour une certaine catégorie de clients ayant moins facilement accès à vos services ou vos produits).', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a05b2a2a-126e-4220-b393-2a4903d9f544, 4, 'Un engagement en faveur d''un impact positif spécifique sur l''environnement (par exemple, modèle d''affaires basé sur la location, la réparation et/ou la réutilisation plutôt que sur l''achat et l''élimination).', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (570a44cc-ae9e-49fa-85b2-5f5c02dc6b5f, 5, 'Nous n''avons pas de mission écrite et formelle.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e3915b4f-6ed0-442b-8940-3d8b6c01a554, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (314d7804-1bf0-4eb1-bfe6-bbf4d9f893c0, 1, 'Nous sommes conscient·es des objectifs de développement durable (ODD) des Nations unies et de leur importance.', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c10a21ef-d470-4b62-b290-e46eb5b293da, 2, 'Nous sensibilisons nos travailleur·euses aux ODD et les impliquons dans la poursuite de ces objectifs.', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d8c8f485-56a5-45a5-aa05-ce944b6db785, 3, 'Nous alignons les activités et les initiatives de l''entreprise sur des objectifs de développement durable spécifiques.', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5154a864-3800-4856-b751-3202738a278a, 4, 'Nous disposons d''indicateurs de performance ou de mesures de réussite pour mesurer l''impact positif de l''entreprise sur les ODD.', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (91e8c53a-eb3b-441c-a29c-c2d98def7f97, 5, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c89a2e69-3952-43b0-bbf4-6234e584d98e, 6, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (08609a0a-8060-49be-8787-faa4e01029a2, 1, 'Cartographie des parties prenantes : Nous avons identifié et classifié les parties prenantes internes et externes pouvant avoir un impact sur ou être affectées par nos décisions, telles que les employé·es, les actionnaires, les client·es, les régulateurs, les investisseurs, et les communautés locales.', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (51752a1c-51f7-4ea5-9761-ef33ce809084, 2, 'Évaluation de la matérialité d''impact : Nous avons analysé les enjeux environnementaux, sociaux et de gouvernance (ESG) les plus importants pour l''entreprise, en termes d''impact sur la société et l''environnement.', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d88005a2-7b47-4bfa-ad2a-4a127ed264eb, 3, 'Évaluation de la matérialité financière : Nous avons identifié les risques et opportunités liés aux enjeux ESG ayant un impact significatif sur les revenus, les coûts et la valeur de l''entreprise (inondations, sécheresse, grèves, etc.).', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (93e4acea-0854-4ce4-b26b-80be84acf9cf, 4, 'Rapport au conseil d''administration : Nous avons présenté les résultats de l''engagement des parties prenantes et des évaluations de matérialité au plus haut niveau de supervision de l''entreprise, tel que le conseil d''administration.', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e9009f74-8547-415c-a33f-74f1cddc0846, 5, 'Analyse comparative : Nous avons réalisé une analyse comparative avec les pairs de l''industrie pour identifier les app.questions matérielles communes et les défis spécifiques à l''industrie qui devraient être abordés par l''entreprise.', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (862f2a39-f313-4bf8-9bc8-879b5ad38206, 6, 'Matrice de matérialité : Nous avons élaboré une matrice visuelle de matérialité qui illustre l''importance relative des différents enjeux ESG pour l''entreprise et ses parties prenantes, facilitant ainsi la priorisation des actions.', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c6e43730-9964-4543-be4d-bd386a0ac4a7, 7, 'Collaboration avec des experts externes : Nous avons travaillé avec des experts externes en matière de durabilité pour auditer et valider nos analyses, assurant ainsi la crédibilité et l''exactitude des évaluations.', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (edbb3d2a-27e2-4003-88aa-9cc9a375b1a0, 8, 'Intégration stratégique : Nous avons intégré les évaluations de la matérialité d''impact et financière dans la stratégie globale de l''entreprise, incluant les processus de gestion des risques et les plans d''action pour atténuer les risques identifiés.', 0.6666666666666666);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e5e55310-2ac5-45fb-8fa8-5b4e11777512, 9, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (85bc93f1-7468-43a2-8ebf-0690529733ef, 10, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (1e0c80ce-1db6-4df2-8bda-05ad8c6a4847, 1, 'Notre consommation d''énergie, notre stratégie et nos pratiques pour la réduire.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e65cbfa7-870d-458d-849a-e7b65126ca94, 2, 'Notre empreinte carbone, notre stratégie et nos pratiques pour la réduire.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (81462e0c-103e-4af1-b5aa-f1e800475e20, 3, 'Notre politique d''achat responsable.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (3c211607-1e5d-4e27-b51c-7bf1cc3c15f4, 4, 'Notre consommation d''eau, notre stratégie et nos pratiques pour la réduire.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (91c6b8a8-cfdb-4423-b27c-4987fd45dfbf, 5, 'Notre production de déchets, notre stratégie et nos pratiques pour la réduire.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (51b40391-2acf-468a-8e57-2ad7048ba4ae, 6, 'Notre stratégie en matière de circularité et/ou biodiversité.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c80cb97b-ad9f-4af3-8f4a-482978518ed6, 7, 'L''impact de notre modèle d''affaires sur l''environnement.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4ec91b64-bb9c-4c9c-8a72-b468ca6cfce2, 8, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (3465c039-276c-4563-bcb4-fc3e6cad58fa, 9, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4a5e2969-8f31-4e54-8061-cc6b7fa8c1a5, 1, 'Notre politique et nos performances en matière de promotion de la diversité et de l''inclusion.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (fbd27d2b-d9ab-4da1-bd8b-4c99e90241f8, 2, 'Notre politique et nos performances en matière de sécurité au travail.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (86e5f5a2-a04b-4f35-a4ae-3d024ab1e20b, 3, 'Notre politique et nos performances en matière de promotion de la santé et du bien-être.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (dc179ca1-9ad7-43b0-91c5-0ecbd84d36cf, 4, 'Notre politique et nos performances en matière d''engagement civique', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (fa04d9f4-73a9-4e36-89d8-94747f9b581f, 5, 'L''impact de notre modèle d''affaires sur la société.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (01797691-aa82-43f5-90fc-03fe1bfa9b65, 6, 'Notre politique de formation et de développement des compétences', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c22e64b7-09e6-4eb2-bbed-b56364e2bcb4, 7, 'Le taux de satisfaction ou d''engagement de nos équipes', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (0cca3036-1878-4ea9-8591-6e0d41795a81, 8, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c85854a0-219b-4214-bd93-f4e52de9386c, 9, 'Aucune de ces réponses', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (60d8a3ff-be01-49ca-8a79-e8d832b430b9, 1, 'La composition du conseil d''administration.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9c9579fe-4217-45b3-aa51-51030b1c3b7c, 2, 'L''organigramme de l''équipe.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (8e04ca88-f0ab-4626-b902-7f56c598d15c, 3, 'Les résultats financiers (au moins transparents pour les travailleur·euses).', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (aa27d7f1-b95a-43e0-8ac9-de2084c69631, 4, 'La mission formelle et écrite.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (7f4dd2e3-6d15-40dd-b518-c88beed13366, 5, 'L''intégration de nos parties prenantes dans la gestion et la stratégie d''impact (informations sur la manière dont l''entreprise engage le dialogue avec ses parties prenantes (client·es, employé·es, actionnaires, communautés locales), et comment nous intégrons leurs attentes dans notre stratégie.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (268c6dd3-88de-422c-96f2-7965da53b18b, 6, 'Les Objectifs de Développement Durable auxquels nous contribuons directement et indirectement.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (57aa4968-470d-4267-a4f5-5ee026cadb33, 7, 'Notre politique en matière de gestion et de protection des données (site web : cookies, guide d''utilisation, RGPD).', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (dd2eb117-69ac-4024-bd9f-2f968d523208, 8, 'Le taux de satisfaction de nos clients.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (7eb69404-6949-4789-8d8f-426500fec195, 9, 'Autre : veuillez expliquer dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (535d920a-749a-4573-a905-d12ddded8bba, 10, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e8648cbd-2ff5-4fa3-baa8-44ef2aadd4d8, 1, 'Nous n''avons pas de rapport d''impact.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d3bd7d11-0220-4476-99c7-1d14be4a2d93, 2, 'Élaborer un rapport complet de durabilité qui divulgue de manière transparente les impacts, les performances et les progrès de l''entreprise sur les app.questions importantes.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e2092c4b-fc23-43d6-ac0e-6f1950b97bf0, 3, 'Élaborer un rapport intégré, qui combine les informations financières et de développement durable d''une manière holistique afin de fournir une image plus complète de la performance de l''entreprise.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (86074d11-6e54-406a-9465-1e474807f7fb, 4, 'Aligner les rapports sur le développement durable sur les objectifs de développement durable des Nations unies, en montrant comment les activités de l''entreprise contribuent à des objectifs mondiaux plus larges.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (252c7155-f487-4aa7-943d-adab7d4a0580, 5, 'Obtenir l''assurance d''une tierce partie pour les rapports sur le développement durable afin de renforcer la crédibilité et de démontrer l''engagement de l''entreprise en faveur de la transparence.', 0.1923076923076923);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (471a9615-2b66-4938-935b-42adbefcb53f, 1, 'Code de conduite éthique : déclaration écrite claire de la mission de l''organisation, ses valeurs et ses principes éthiques, sa politique de conduite éthique des affaires, le respect des droits de l''homme, les normes de travail équitables, sa politique pour adopter un comportement responsable à l''égard des parties prenantes, y compris les client·es, les travailleur·euses, les fournisseurs et les communautés locales.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2fcedb12-70d2-40d5-9619-3f567a57edac, 2, 'Code de conduite interne : déclaration écrite sur les normes de conduite professionnelle attendues de tous·tes les travailleur·euses, y compris l''interdiction de comportements inappropriés tels que la fraude, la corruption, le harcèlement et la discrimination.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (6488ad41-d6db-4036-a02e-6b7471d80e83, 3, 'Charte sur les conflits d''intérêts : déclaration écrite des politiques d''identification et de gestion des conflits d''intérêts potentiels, et de divulgation transparente des relations financières et personnelles susceptibles d''influencer les décisions de l''entreprise.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e39a3a98-5f5c-4273-b0ad-950a9c323803, 4, 'Charte de lanceur d''alerte : déclaration écrite encadrant les modalités par lesquelles les employés ou parties prenantes peuvent signaler des comportements illégaux, contraires à l''éthique ou mettant en danger l''intérêt général, tout en garantissant leur protection contre d''éventuelles représailles.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (62226db7-0715-470d-8028-48463462bb61, 5, 'Protection des données et de la vie privée : déclaration écrite et partagée sur la confidentialité et la protection des informations sensibles des client·es, des travailleur·euses et de l''entreprise, conformément aux lois et réglementations en matière de protection des données.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2c94d455-34ae-4ab7-9f6c-01c8a1f1815f, 6, 'Charte Diversité et Inclusion : déclaration écrite et partagée formalisant l''engagement de votre organisation à promouvoir l''égalité des chances, à valoriser la diversité et à créer un environnement inclusif, respectueux et exempt de discrimination.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (a806c032-f8d5-4d39-9afc-cabfedd2d341, 7, 'Charte d''engagement civique : déclaration écrite et partagée qui exprime les principes et actions par lesquels une organisation et ses membres s’engagent à contribuer positivement à la société, par le biais d''actions concrètes ou de philantropie.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c94141ff-5abf-4101-b701-87145cfdd440, 8, 'Code de conduite Fournisseurs : déclaration écrite et partagée avec les fournisseurs qui définit les standards éthiques, sociaux et environnementaux que les fournisseurs de votre organisation doivent respecter dans le cadre de leur collaboration.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ca2c6221-cb96-438e-b149-f3cc6ce45df1, 9, 'Politique de télétravail : déclaration écrite et partagée pour promouvoir les bonnes pratiques pour gérer l''impact écologique généré par le travail à distance, incluant la consommation d''énergie domestique, l''utilisation des équipements numériques, les déchets électroniques et la réduction des déplacements professionnels.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (6cd6c4d2-6bc0-4b7a-a4c2-b37c35d67f21, 10, 'Charte d''achat responsable : déclaration écrite et partagée qui formalise les engagements d''une organisation à intégrer des critères éthiques, sociaux et environnementaux dans ses pratiques d''approvisionnement et ses relations avec les fournisseurs.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d2143627-4762-4d7f-923f-42061b271264, 11, 'Politique sur le marketing éthique : déclaration écrite et partagée qui établit les principes et pratiques d''une organisation pour promouvoir ses produits ou services de manière transparente, responsable et respectueuse des valeurs sociales, environnementales et des consommateurs.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (89c760c3-6fe6-4966-ab57-dd0a221aa867, 12, 'Charte sur les clients des secteurs controversés : déclaration écrite et partagée au sein de l''entreprise, définissant les critères éthiques et responsables qui guident l''acceptation ou le rejet de partenariats avec des entreprises évoluant dans des secteurs jugés socialement, écologiquement ou économiquement problématiques.', 0.4166666666666667);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2487d1a7-8c3d-4a49-a352-3446556199e7, 13, 'Aucune des réponses ci-dessus.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b36a3657-de88-4077-b440-4047eb97705d, 1, 'Une déclaration claire de l''engagement de l''entreprise à prévenir et combattre la corruption sous toutes ses formes.', 1.6);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f9168822-5858-4dc5-bd85-943cc3c144e0, 2, 'Des lignes directrices sur l''acceptation et l''offre de cadeaux, divertissements et hospitalités, conformément aux normes légales et éthiques.', 1.6);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (801dd41b-ce2d-4e2c-a47a-e5bab12dfa52, 3, 'Des formations régulières et des programmes de sensibilisation pour éduquer les employé·es sur les politiques anti-corruption et leurs responsabilités.', 1.6);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (55ede1db-9e1f-484c-9656-81d2d3ee6b40, 4, 'Des mécanismes de signalement et une protection pour les personnes signalant des soupçons de corruption.', 1.6);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b0422232-4f28-4461-b573-0c7b919f2d12, 5, 'Des procédures de vérification préalable (due diligence) sur les partenaires commerciaux, agents et tiers pour atténuer les risques de corruption.', 1.6);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (abc8815f-6419-4c5a-9101-83a841dc164f, 6, 'Des contrôles internes et des mécanismes de suivi pour détecter et prévenir les pratiques de corruption.', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (253d784c-234b-41ce-afab-79f09b128dfb, 7, 'Aucune des réponses ci-dessus.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d2ee0009-d329-43fc-9fbf-33258296cf49, 8, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5ce1f6f9-6579-4f87-827b-faa010049bce, 1, 'Plainte pour harcèlement ou discrimination', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f32f9931-066b-46f6-b4e7-9447213242c2, 2, 'Litige relatif à l''**éthique des affaires**', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (9f1ba6d6-3d6f-4e42-b866-00eb07b01837, 3, 'Litige social', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2c8c9283-ee31-40ca-99dd-ea961b3113a7, 4, 'Grèves', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4ae2f248-9ed0-4085-875d-f0787ab30f37, 5, 'Autre : préciser', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (36874394-0ebc-4a5a-ba84-4be7bb190435, 6, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (859e4208-ebf7-441a-8132-90c56e476e86, 1, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (cc9355a2-b7b1-4eb5-9690-5bf85bcea0ee, 2, 'Oui : préciser', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (7ceec756-9915-4390-bfa2-0e8307d0ad2a, 1, 'Tous·tes les travailleur·euses ayant accès aux données sont formé·es aux politiques de confidentialité des données (protection des informations sensibles, la prévention des fuites de données et le respect des réglementations en vigueur.', 1.142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (b4f657d6-d665-44cd-a165-d4de7645c7c8, 2, 'La désignation d''un.e responsabla à la protection des données (DPO - Data Protection Officer).', 1.142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2c4755fe-5b6d-477b-b307-8b782def86b3, 3, 'Une politique de cybersécurité clairement définie incluant notamment l''identification des cyber-risques.', 1.142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (bfc1209f-b740-4bb1-be41-4517b7c97fc1, 4, 'La réalisation d''audits externes incluant notamment des test de phishing, d''intrusion et de piratage de la sécurité des données.', 2.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (7ded84c0-8545-40fa-8b72-3f893695504d, 5, 'Une couverture d''assurance contre le cyber-risques.', 1.142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (fd39a881-8128-40cc-997e-f1d8dd2cebf4, 6, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (52a91cdf-cd67-453f-8b6b-5bd3b2355bec, 7, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4860c811-9ead-42e6-ac4c-4094ab4a24ae, 1, 'Nous avons mis en place quelques mesures de base mais nous ne disposons pas d''une politique de protection de la vie privée formelle.', 1.142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (1317fb61-0e21-4ca7-8cde-bc0b37db2c78, 2, 'Nous avons formalisé la politique de protection de la vie privée avec une déclaration claire sur notre engagement à protéger la vie privée et la confidentialité des informations personnelles.', 1.142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (793664ee-c228-45e0-aafb-731adaa19ae4, 3, 'Nous contrôlons, révisons et mettons à jour continuellement la politique pour faire face aux risques émergents et à l''évolution des exigences réglementaires. ', 1.142857142857143);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (80d0b175-991f-4d98-b000-041d7bbdf43c, 4, 'Aucune de ces réponses.', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e2008e92-ad3a-45c2-b89a-1fb3b120dfbe, 5, 'nan', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (c68ad110-1e0b-4bdc-9399-987e19c54e5a, 1, 'Oui', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (ab49d542-9a0a-4c1d-8278-1400c907d23d, 2, 'Non', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (09c398d8-608b-4d2d-820f-a2af236b6448, 3, 'Je ne sais pas ', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (4a1484b7-1ce8-4394-8ba7-b5cd97d28a3b, 1, '0', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (33da04b8-04d4-46f8-ae3e-f0e682aee07e, 2, '1-24%', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (6aab36b8-9fc0-48ae-884c-5b6f5e44ad26, 3, '25-49%', 0.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (21f41180-3c93-4459-933c-6a9a1eb0d703, 4, '50-74%', 2.5);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (d32398db-b666-48de-984e-9a1d3d5a84cd, 5, '75-100%', 5.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (3d66904d-d2c8-47d1-b407-4188667b2240, 6, 'Précisez le nom de l''organisme et/ou label : ', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (dfa214b7-4601-4521-8495-4eeb133eb9dc, 7, 'nan', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (2cb7f154-1bdf-4c4d-8dd9-fe83af07a638, 1, 'Benefit Corporation (B Corp) ', 5.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (e5c56d0f-8f8d-4398-99fc-57d7edae23ca, 2, 'EMAS ou ISO 14001 - Système de management environnemental ', 5.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (f0dc87ea-a24f-4081-b057-5247b7350c6e, 3, 'ISO 26000 -  Responsabilité sociétale ', 5.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (6922e321-189f-4623-88a2-8599970186ef, 4, 'ISO 9001 - Système de management de qualité ', 5.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (51ff2d70-4c4a-4a81-ba85-05edb5aa276d, 5, 'Label Diversité et Inclusion', 5.0);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (5c93acd0-635a-477a-ac2d-e0e220e43677, 6, 'Autre : veuillez préciser dans les commentaires.', nan);
INSERT INTO app.choices (id, index_choice, value, score) VALUES (244d4e88-91a1-48cf-a8eb-84808d2b9265, 7, 'Non', 0.0);

-- Insert questions
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (b97cad22-5663-4465-8376-22aa69cc582b, 1, 'ALL', 'Suivez-vous la consommation d''énergie de XXX ?', 'qcm', [c296871c-8e85-48d6-ae7f-5ad455a106b2, 12f9f09f-0c99-4328-8098-fb7c23ce97cb]);
INSERT INTO app.questions (id, index_question, template, value, type_response) VALUES (fc4177a9-bfd8-4a4b-8d44-fc2a9d1909b1, 2, 'ALL', 'Si vous la suivez, veuillez indiquer votre consommation d''énergie totale des 12 derniers mois (en kWh)', 'question ouverte');
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (e83569e0-0035-4015-a162-f54998f30a67, 3, 'OWNED FACILITY', 'Avez-vous un contrat vert avec votre fournisseur d''énergie ?', 'qcm', [299d1c40-1d22-4fdb-a21a-0a1494edf980, e825f22b-b58d-4b69-bb27-bc0429e0b65e, 2eeefed7-73ce-4241-bcbb-d33805494900, d2f86ebd-7dd0-40ed-b78a-d3e9a4b4859e]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (020125df-3153-4a25-a4d9-29487badf404, 4, 'OWNED FACILITY', 'Produisez-vous de l''électricité sur site (par exemple, avec des panneaux solaires) ?', 'qcm', [6557d2fe-434b-4770-95a5-9bc07246ef21, baa21c6d-ee13-43ba-8921-dddb0be6b6d4, b12f7309-312d-4499-95c3-d0781fe1892e, 04e7f911-c973-415e-af92-76f0f932a986]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (51c8907b-ad07-42bc-ada4-61acd4dc2172, 5, 'OWNED FACILITY', 'Qu''avez-vous mis en place pour limiter votre consommation d''énergie ?
Veuillez sélectionner toutes les réponses applicables.', 'qcm', [f0037730-4d5b-4426-ac09-17411d4ce3b7, 66457af2-bef1-4d73-a8c2-08b4b825c58c, 0ca28dc6-3377-4a69-9d77-1338efaee097, 32d5c7cb-9530-4879-85e6-55dc179a1cdb, 04f4e97b-65e0-4f89-ab3f-63033e195bf7, b0a05fc2-74ec-47f4-a3a2-df07d66b7e51, 67043484-5411-4cf1-820b-1ef375849b74, 5905c1d4-036a-4b74-996f-c9e25d0bad65]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (022c73c7-6cce-4a1d-937a-4bf73f364368, 6, 'WORKERS', 'Avez-vous mis en place des initiatives pour sensibiliser vos travailleur·euses sur les bonnes pratiques en matière de consommation d''énergie ?', 'qcm', [254e48ea-535a-4cb1-9d58-589484f0ed74, ee38c137-4a72-4ba4-a54c-4bcdd1480ae4, c425e2c9-b430-4db0-85a6-f4dc4c1419ff]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (d870a33c-b9ae-450e-8ec7-90ed32110dba, 7, 'ALL', 'Avez-vous calculé l''empreinte carbone des activités de XXX ?', 'qcm', [5e5fd806-1c88-4aa4-a19c-d99ed8788e1c, 05d770ba-ae2f-44de-82e4-58cc17dc97d1, da9a1200-884d-4ae8-8cc6-190dd8e45682]);
INSERT INTO app.questions (id, index_question, template, value, type_response) VALUES (ca81bec4-e57d-470c-afc5-12568d639139, 8, 'ALL', 'Si vous la calculez, veuillez indiquer votre empreinte carbone de Scope 1 (en tonnes de CO2 équivalent) :', 'question ouverte');
INSERT INTO app.questions (id, index_question, template, value, type_response) VALUES (ee2f05e4-3309-4518-9311-954ac3c5fb9b, 9, 'ALL', 'Si vous la calculez, veuillez indiquer votre empreinte carbone de Scope 2 (en tonnes de CO2 équivalent) :', 'question ouverte');
INSERT INTO app.questions (id, index_question, template, value, type_response) VALUES (4daf4517-0d1c-470d-b4b2-113143111773, 10, 'ALL', 'Si vous la calculez, veuillez indiquer votre empreinte carbone de Scope 3 (en tonnes de CO2 équivalent) :', 'question ouverte');
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (282ade19-d0ef-4185-a79f-2bdcf3ddc62f, 11, 'ALL', 'Si vous avez réalisé un rapport d''empreinte carbone pour XXX, que comprend-il ?
Veuillez sélectionner toutes les réponses applicables.', 'qcm', [4eef3aa2-7758-4ab3-ada1-0ff8f8fb5f82, 328619fe-26b8-4083-a271-66e2b042bd53, e8bcede2-4520-42fd-9a8f-4e7d87ea5e73, 35fe40f1-3d70-4b8b-a84e-e0819c85112e, 47383c61-dbd2-423f-9eba-c40c654ae853, aa8f5394-3117-4717-bfa4-c11e60e98350, bde98f9a-3d31-4514-8cc9-f6e6068b138a, fa4cafad-fa5e-4c26-9998-4a307a4991c2]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (e43bcb4f-47a8-4149-8b67-478e371ec459, 12, 'WORKERS', 'Quelle(s) pratique(s) avez-vous mise(s) en place pour limiter votre empreinte carbone ?', 'qcm', [ebd08297-5ff8-4ac2-840d-bdae25845a82, d76275f5-3cca-4689-b7cb-8df0845abe18, 385ef2aa-5eb9-410d-81a7-c13ee65f3897, dc1291b8-13d8-45ec-9553-828ef64672ae, 3324dbfd-ff77-45dc-947f-2dc22c1e164a, 87e934e8-f261-4a3e-9ce8-39ba714fb885]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (e6bd41c3-db6c-407c-8404-2e924e4be0b2, 13, 'WORKERS', 'Proposez-vous des ateliers de sensibilisation et des formations sur les émissions de gaz à effet de serre à destination de vos travailleur·euses ? (par exemple, la fresque du climat)', 'qcm', [822f82e3-163e-4e60-abb4-f595127ba190, 557c4411-5785-4cbb-bd7a-c83a6df0c764, 5694f27b-8110-4a62-b94c-16662836f66a]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (89513142-f5af-4f85-9d64-7734a8a19d6c, 14, 'ALL', 'Quel pourcentage de vos fournisseurs (en valeur monétaire) se trouvent à moins de 80 km de vos installations ?', '%', [fdd79aed-1f16-45fb-95c9-808179a130ca, 53836e55-4cbc-48b7-8e74-e17347bdfbd4, 9cad1922-707b-4009-bd02-cd0d4dfe9ce5, 0bd543ce-f73d-4d4d-8a95-582466d9beb3, c7b9cb9f-97d0-40c1-a8d8-f6ded4e62333, 4fc4809d-d43a-4dbf-98db-a382ce3423b6]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (ed3db903-6dde-4f8f-9a2b-0a97aa998bef, 15, 'PRODUITS', 'Quel pourcentage de votre transport amont et aval (approvisionnement et livraison) est effectué à l''aide de modes de transport à faibles émissions de carbone (par exemple, vélo-cargo, train, voilier, etc.) ?', '%', [5329d5c0-520f-41e7-873f-16ea125a3487, 10467bdf-2e0d-4d25-84d9-febcc88fc070, cfd37711-4d31-42c6-85fa-0f61b3de5a2c, 46699c68-e3b5-4002-ba02-3ac945796938, 476d1e63-6295-489a-8aa3-7f930ddb351b, 3cb4b5dd-340c-484e-9425-763d164e6931, e5b0d930-5933-43d4-85f9-29eae853db6c]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (87fd8182-1d83-441d-9e9a-f8c7debd7243, 16, 'PRODUITS', 'Avez-vous optimisé votre chaîne de valeur afin de réduire les distances de transport, par exemple en rapprochant vos fournisseurs, en centralisant vos sites de production ou en réorganisant vos réseaux de distribution ?', 'qcm', [17efcf1c-f31b-4202-81e0-9698fea805a1, 515290db-2624-4a21-aba0-92c3974406c7, fc778a77-90fd-4f81-80b3-3be948c12ff4, a9e341c4-bd8e-437e-a23b-85aff5ecdcd6]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (f43c3a5c-3536-4893-9bd8-293ae46cd86e, 17, 'ALL', 'Quelle(s) mesure(s) avez-vous prise(s) avec vos fournisseurs pour limiter les émissions carbones liées à votre chaine d''approvisionnement ?', 'qcm', [94cf2265-3f05-40c6-bc3e-bc678c77005d, e38278a7-9ed3-4666-abea-725cc158f5e6, 0c3c3ca7-3c1e-47ad-8459-50cdf07e75e4, 425ff650-398d-4525-9543-f772074e4035, 95296474-6c05-4a66-b640-6b8b35a7770f, 169c3098-e569-4fc3-9dce-236c867b8d3a, b6b6cf53-ae25-4c38-91ad-c093144aa1de, 6f71d88d-8c36-4813-8a59-3c0de728d039, 33d8ffc6-a8f1-4d3d-9b8f-43235026dddb]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (ad0bd53d-3d92-4d8c-8e52-7041f5602858, 18, 'FACILITY', 'Mesurez-vous la consommation d''eau de XXX ?', 'qcm', [6f1e2659-2cf2-4735-9eea-c1d792ac66ac, 1c27d6ff-8214-42e7-ab88-8e46aff8afc9, ef0fc7f7-61c2-4b01-977b-6b78d38b3b59]);
INSERT INTO app.questions (id, index_question, template, value, type_response) VALUES (1bd6184d-57b4-4de2-aa6e-c3147fce6f09, 19, 'FACILITY', 'Si vous la mesurez, veuillez indiquer votre consommation d''eau (en litres) :', 'question ouverte');
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (97e947fe-541a-4688-bcb3-2ef719d9eea0, 20, 'FACILITY', 'Qu''avez-vous mis en place pour limiter votre consommation d''eau ?
Veuillez sélectionner toutes les réponses applicables.', 'qcm', [a8ec73b9-8e1f-475a-8733-d13652a38a24, 5302a0ea-c318-4fd7-9907-b7e6b22c64fc, b52035b9-adbd-46ce-9837-8757f2a058b7, f3c89deb-7985-4572-9e35-99dfb1a1f9b2, 499ce711-d341-4f87-97e9-f230596c9789, 02d0fc21-6358-4110-9ebb-7ecea9024293, e5d475fe-8e28-4f09-9b31-41ef508c1e14, 72978539-072b-4ebe-a3d9-b7717fac066f]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (730778da-2198-43fc-814f-32db39f06416, 21, 'WORKERS', 'Avez-vous mis en place des initiatives pour sensibiliser vos travailleur·euses à la gestion de l''eau et à sa consommation ?', 'qcm', [76884ba1-f3f9-44fb-bf57-d50e17e2c777, bee3eb7e-ecc4-421b-874e-07e14ca73523, c91c3575-c930-406f-afed-c7bd2410f7b5]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (5c33265f-b12f-4cda-a25d-87f8e7ac1359, 22, 'ALL', 'XXX a-t-elle pris l''une ou plusieurs de ces mesures concernant la consommation d''eau dans sa chaine d''approvisionnement ?', 'qcm', [30ad6320-8975-4016-98a5-09d7f056779d, 58830c9b-b60c-445a-b602-1a9ac7bc5593, 08bffcc8-65fd-41b2-87db-89fa5be22cf7, c64fed8d-4608-4cb3-ae8d-ec24fa228151, 0c46d0f6-a0ca-4bf1-84d9-a570b2fb91d2, 823fd566-eaa7-4f8e-8d43-59605af3a150]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (441a56d0-0d05-4278-8d32-0c061fb1ff8d, 23, 'PRODUIT', 'XXX a-t-elle pris l''une ou plusieurs de ces mesures concernant l''utilisation des ressources ?', 'qcm', [68d8fb45-5403-4c9c-91f6-721001b760da, a1b19035-af49-4dd6-afe3-21067df825c0, 78250b0e-d9c6-4b41-8c2e-961baf6d610c, 6ac30a7d-de85-4f99-a88d-05c49efb9fcd, eeb1bf1b-74dc-4bb8-8545-544714d2ccbe, 58278cc5-07cb-4562-bfbd-234cb1103908]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (0da6eaa9-9da6-47ac-8618-36931ff4b556, 24, 'WORKERS', 'Avez-vous mis en place des initiatives pour sensibiliser vos travailleur·euses à l''utilisation des ressources ?', 'qcm', [e534d8e3-11af-4485-8270-b0184a398256, 9f3fa84a-4554-48a9-99e7-4be05c01f781, 2766494e-222c-4257-afa8-180b96e402c6]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (d25ee249-1452-4c8d-a99c-ab64297a6a46, 25, 'PRODUIT', 'Quel pourcentage de vos matériaux (en volume) provient de matériaux recyclés, de composants réutilisés et/ou de matériaux certifiés d''origine durable ?', '%', [2dbf24c3-9e6d-4898-bc63-762cb2d394fb, b5dee924-e1c4-466b-b3a3-ca5ee95ca475, c110f833-2307-4a5a-a625-e198f5599e26, 722b8fbd-97e0-45fa-870f-9d39d7d582e7, 8a35b1be-40b9-4d67-a780-888d36171a9e, 136c8c8f-b7a4-46b5-a6e0-5d2d23ed0676, a767aa00-1ace-43b2-9243-ff12bc10365c]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (82cfa8be-93e6-49a7-9e72-2f3b8bcad788, 26, 'FACILITY', 'Suivez-vous les quantités et les types de déchets produits par XXX ?', 'qcm', [d066938f-3c5f-46fa-8390-2ce47699fd16, 20ba2465-23d7-41a7-b548-6d05a6f9cefc, a8dc7a95-c4de-4fe2-808f-d85c8cd9de18]);
INSERT INTO app.questions (id, index_question, template, value, type_response) VALUES (b26996f9-daea-45be-b789-45d8a2a7c65c, 27, 'FACILITY', 'Si vous la suivez, veuillez indiquer la quantité totale de déchets produits par votre organisation au cours des 12 derniers mois (en tonnes) ?', 'question ouverte');
INSERT INTO app.questions (id, index_question, template, value, type_response) VALUES (143504a9-e522-4e7b-9296-a5893843f5a5, 28, 'FACILITY', 'Si vous la suivez, veuillez indiquer la quantité de déchets dangereux produits par votre organisation au cours des 12 derniers mois (en tonnes) ?
(exemples de déchets dangereux : équipements électroniques, piles, cartouches d''encre, déchets industriels, batteries, peintures, etc.)', 'question ouverte');
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (1b76b71c-e65d-43aa-9ca9-dc9db31d9c22, 29, 'FACILITY', 'Quelle(s) pratique(s) avez-vous mise(s) en place pour réduire la production de déchets et optimiser leur gestion ?', 'qcm', [933add90-8169-481d-8b78-a22dd455f809, 229446af-f6aa-4671-bcc9-9080c8cddc5d, 0af33ac1-987f-4cd6-8a9f-4d012b08ebf0, 0e203cb2-1017-4302-a281-4ef62da57888, 78c5dcbc-3a5b-4306-8569-207023ee1758, 94864be8-eedb-4ed3-b4bc-1991af9feab4, 1efc6428-3967-4e45-8499-ad47bf317d07, c4716590-a5cc-4176-a31d-5d9bd8ca0bf8, 57f839b3-8ed8-4482-a5c5-9ae80f4da5ba, b81a7c03-c341-459a-86c3-84dfd3f1f014, 296129cd-3ffb-4a32-8386-e1eb880551ff]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (d52786c5-0eb1-477c-8a94-d501756e0cfb, 30, 'WORKERS', 'Avez-vous mis en place des initiatives pour sensibiliser vos travailleur·euses à la réduction, la gestion et le recyclage des déchets ?', 'qcm', [c9e9f953-4660-4c45-86e8-97ca713e653b, 0f6aea36-ab94-4a66-af11-4488b6c6b102, 39ed4d65-a681-48e8-88a8-430b35fef5cc]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (6bebf7fc-9eb5-4926-a2fb-726a1cc10b08, 31, 'PRODUIT', 'Quelle(s) pratique(s) XXX a-t-elle mise(s) en place en matière d''économie circulaire pour limiter la production de déchets ?', 'qcm', [e656d3cf-a802-4f81-bb96-4cc6451f0882, 1337cfe8-8f34-43bd-9552-b2d8c5b6a2ba, 480840a1-655d-41df-a843-634b77344345, 86cb0beb-cd0d-4173-9a77-78514c4c8836, ee4bed01-ab0e-4478-94f7-900ef92c05d7, 0acbc811-a96b-4a59-b4f1-7dbc9c53c810, 2dd049de-b57a-48c1-8694-efbca7091b36, fb2c2f93-7238-4511-9b65-6f2e6b14cd7d]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (4761732e-7397-4aed-9178-9aaa9b2ad63b, 32, 'PRODUIT', 'XXX a-t-elle mis en place une ou plusieurs initiatives visant à protéger les écosystèmes et préserver la biodiversité ?', 'qcm', [29aad371-5f9c-465c-b8b8-67cc0b0ef792, 9888f570-3b97-42a4-be11-7ca5159516b2, 8aa8b0fa-702b-4c94-ae91-dc1efdd5b46b, 4044d1e3-9063-4b43-866a-a4fb6071d5f1, 48356442-dac3-437c-a36b-0f977224cefb, de162c52-7f1e-477a-98c8-af786193ab25, 127fe6c6-093d-42db-83e3-a859c6c95a52, 7e998081-973d-4309-86b0-353832132f9c, 043ab984-1c7d-4f99-84a5-a9f85a6593a4]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (b51a9007-ef66-453e-afe7-7c363334402e, 33, 'WORKERS', 'Proposez-vous des ateliers de sensibilisation et des formations sur biodiversité à destination de vos travailleur·euses ?', 'qcm', [b5506fd2-527a-413c-932e-e821f48ada33, dd1b1c61-9761-497c-a755-4875d668fca3, 2186b15c-15b4-4e38-82a2-8e30798fbbbb]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (764533ba-cf51-4ae3-9947-e346436e31bf, 34, 'WORKERS', 'Comment XXX crée-t-elle un processus de recrutement et d''embauche inclusif ?', 'qcm', [870f0f43-2cff-4657-8c31-1d60e3446ba5, ff0beb26-d391-4e67-93c4-bfea26cba54a, 64703b06-9147-4640-a74c-5811a70ec253, a90115eb-157a-4b9d-9836-33a60a95c4cb, 80c3ce15-545f-4b20-9e52-85c88ce9e73e, f071ce0f-01b8-4670-9cad-12e941fde029, 494a03d4-2cc1-46d3-ac28-e7e50ccb2c98]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (69be1067-51a9-4a22-bfe5-098d5db64028, 35, 'WORKERS', 'Comment XXX crée-t-elle un lieu de travail équitable et inclusif pour les travailleur·euses ?', 'qcm', [e26a67f7-8a2a-463c-b144-b093ed70960c, 8f8032c3-35bf-43c2-82c2-ca8b5eb2c91a, 5de05c4a-cca2-4d17-ae56-a413ac687084, 086045f2-42bf-4a0b-9f64-1e352fb83127, 911775fe-4b52-4b4a-953b-50a6215ed173, 9d38e811-974a-45a6-a581-b99453597148]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (a3972cf9-35cb-4921-bf67-6fa4f9a40fc7, 36, 'WORKERS', 'En dehors du règlement de travail légal, quelles sont la ou les pratiques suivantes que XXX a mis en oeuvre en matière de diversité et d''inclusion  ?', 'qcm', [014539db-1951-467c-8cd1-8f6149a2f716, 372fd934-7993-4c09-9a16-f2ba4a9a8a5b, b3cd65cf-291d-4746-9852-4f9c4e8657ba, 53a6abd9-f6cc-4339-a79a-8d2e77617195, dfe6d0a5-b96d-40d1-b26c-84fdc9c037b3, 7804e07b-7936-4fe7-a03a-5ab3b1cf91fc]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (a50f4cd7-5fe5-49e1-b8d0-2633dc528950, 37, 'WORKERS', 'Est-ce que XXX monitore les formations en matière de diversité et d''inclusion ?', 'qcm', [e057055f-e848-4f87-a190-b3ae89078b9d, c66b146f-1b2c-448f-8140-d5d0f2357127, b198dc9c-4835-4f33-a18f-e7c7b6b51d33]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (54aa5661-e3b1-497c-9f87-5839cc71c788, 38, 'WORKERS', 'La politique salariale de XXX est-elle régulièrement examinée pour s''assurer que les travailleur·euses bénéficient d''un traitement égal pour un travail égal ? ', 'qcm', [142ea78c-7a7d-417e-9e3f-16c5831f9748, a9e4544e-6023-4a99-aee5-9edc97721604, bcea2bdc-e326-44ae-96eb-a50be1556784]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (0d5245d9-8181-43b8-9ca6-c8012e5bccdd, 39, 'WORKERS', 'Quel est le multiple du salaire de la personne la mieux rémunérée, y compris les primes, par rapport à celui de la personne à temps plein la moins bien rémunérée ?', '%', [0aab81d2-8e08-4a05-988c-82ca6243dd70, 31003cbd-c32a-42fc-b677-20d39305fda6, e7a78612-9d29-4682-8439-0ad5dc96a033, 3d59dbb5-29d8-4742-90e2-bd712848f7a4, 07d7616d-d307-4569-8c30-10e080657c27, b219d4f6-ffd6-4a3c-9222-6129082b9673]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (97d6f369-4137-44f7-bfa1-e68ff637bd2a, 40, 'WORKERS', 'Quel pourcentage des travailleur·euses est âgé de moins de vingt-quatre ans ou de plus de cinquante ans ?', '%', [885e0b68-d28b-4488-b365-4fb9e378d30c, aec36d07-0d1a-4cee-9c9b-73a6f6ba63d1, 5e0a2f4a-9a34-4f56-a2b3-6cb7a47de688, 6759e720-16ff-4fa9-9379-31748556ccf5, 10f357e8-c852-4fae-87b1-83dc17299122, d9547360-6109-47d2-9cd5-6e7934e6ad0f]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (7a8ccbbe-fbdc-470e-a3bb-ebe170e54b18, 41, 'WORKERS', 'Quel est le pourcentage des ***cadres*** de XXX qui s''identifient comme femmes ?', '%', [00eacc52-bfd1-4876-b9f8-7e60fa596671, 369f224e-69ff-4d47-a701-01a52644b2da, a0ecb747-0b86-465f-98f1-1c97b91092d5, 568b1a86-d1f2-481b-ba93-a5f0faa96f3c, 4bed4e3f-aa51-4ca9-9c04-1496b3cd98bc, c452a43f-db5a-4d83-969f-d67a339ecce1]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (2170de86-a872-4624-a7eb-83523392d56d, 42, 'WORKERS', 'Quel est le pourcentage des travailleur·euses de XXX qui s''identifient comme femmes ?', '%', [63f70cb7-091a-46ef-b1f6-5d50d2176524, f70dd594-7793-4d73-a11c-be8720ba6ce5, d239aa43-6ab9-4790-b8ea-04560d45d9f8, 2b5627d1-c804-48f8-a5ed-dc7d21b9f8cb, c3efec7a-7777-412c-a0af-7873a2cb4b13, adeda856-a159-4066-a9ec-18d3cd1547e1]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (8407f8fd-3f9a-483c-85d7-f6f1166abb71, 43, 'WORKERS', 'Quel pourcentage des travailleur·euses se considère comme appartenant à un groupe social sous-représenté (ex : personnes LGBTQIA+, issues de minorités ethniques, etc.)', '%', [9a888fa4-a99f-49e0-a799-85e5aa177240, 5955e3bd-eb6f-429e-9116-cb518eeadd4c, f04401c5-7360-4560-9d09-391baaf41d6f, fbc29b8b-0fdc-425f-8063-a05ed59ecebc, 3e021908-5d8a-4041-916a-ba90e299ee37, 552cb038-43e1-48f2-9112-98b33f361bec]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (da734b4c-f8d5-4343-a0a6-2355060311cc, 44, 'WORKERS', 'Quel pourcentage des travailleur·euses de XXX fait partie d''un groupe souvent exclu du marché du travail (ex : personnes en situation de handicap, anciens détenus, jeunes demandeurs d''emploi, chômeurs de longue durée, etc.) ?', '%', [8149b742-d1e9-41a2-b344-ba2c132b843f, dc41d619-eb3c-4240-9573-0f64862f8b09, 147c5488-a252-448c-bbfc-14d42342c02f, 764e7eae-d591-4e28-bd5d-7f9716a692db, 0d2d5bec-77f8-4f93-bfb7-c4dfa702a4fc, 2d61b872-c4a2-4bb8-ac18-d4298b107978]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (ad83d85c-86c5-459f-8997-67696767ca92, 45, 'WORKERS', 'Comment XXX démontre-t-elle son engagement à garantir la santé et la sécurité des travailleur·euses, en allant au-delà des obligations légales ?', 'qcm', [dcfb662c-4faf-4192-9667-a778a8b89b00, 83ae841d-7bcb-4b8d-b0eb-eaad9fa8514f, 815ee6fe-696d-4618-beb0-f5f801954552, bbfd69ee-bd9a-4803-b23c-cdd2f3602f93, 9a415769-a308-4023-948a-a024520d0869, 41569aec-6a95-4c25-bd5f-2e0b3239bf09, 4137dc22-2b01-4b59-999e-478b0bff12eb, f951fadd-8c7d-4a54-bc81-5a88723c3ba9, 57e9eefd-b5c0-4b6c-a462-2f340081a933]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (f4f50fe2-7c93-49c1-b175-3f7747845b86, 46, 'WORKERS', 'Est-ce que XXX mesure le taux d''accidents dans l''entreprise par année fiscale ? Si oui, veuillez préciser ce taux :
Nombre d''accidents du travail au cours de l''année de référence/ Nombre total d''heures travaillées au cours d''une année par l''ensemble des salariés)*200 000.
Indication : 1710 heures travaillées en 2023 pour un équivalent temps plein en Belgique (225*7,6)', 'qcm', [a4843c21-d4e8-4348-b3d7-b5886917992f, 9009203e-fd47-4da0-9653-dfeefa281f2d, 92923ebe-0254-45d5-9ea3-37b2ff2263ce]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (755fd48d-b200-437b-8c83-820dc7d15d8a, 47, 'WORKERS', 'Quelles initiatives ou politiques en matière de santé et de bien-être XXX propose-t-elle à ses travailleur·euses ?', 'qcm', [a03db7ad-cd6f-43c3-b8ab-5d8e65d17616, 94fd30e7-1c22-4083-8be9-28cd762a84f1, 760dff3f-fe64-4cf9-b38d-5784204ecc89, c087b555-da9d-4ae8-b355-c3506fd4e62a, 5b268e93-4414-4bd4-bee0-6cdb2892bbdf, 62ae8b15-7457-4f99-8ef0-53fa059a3824, c0a66a03-3d30-42a0-abef-346c7cbf84b7, e1a9c265-022c-4362-ac66-9a2c471793ae]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (74fbddf2-1453-4d65-b3f2-ae6dc0b3156a, 48, 'WORKERS', 'Est-ce que XXX mesure le taux d''absentéisme dans l''entreprise par année fiscale ?
Si oui, veuillez préciser ce taux :
nombre de jours d''absentéisme/Nombre de jours de travail * nombre de salariés * 200 000)', 'qcm', [7d9fe843-d095-4a51-8941-6e8d23fa58b8, f9ecf797-42dc-4da0-a9f0-e94a12d96bf9, a0ee0c0a-1ecf-4197-a875-698c2250670b]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (58c7bdf1-34d7-418d-851f-bff0d4df03e1, 49, 'WORKERS', 'Est-ce que XXX a mis en place une politique de formation des travailleur·euses qui prévoit un certain nombre d''heures de formation et/ou un budget annuel par travailleur·euse ? ', 'qcm', [ff2a5f02-e23f-40ce-ba7b-014ac42a7afc, 9b9d77fb-a36e-401e-b4b5-1eba339e01cb, b1322563-4ee4-4082-ada7-94c2914fed70]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (5fcc19c1-5b54-42f6-8b4b-de5072a95ab0, 50, 'WORKERS', 'Est-ce que XXX offre aux travailleur·euses l''une des possibilités de formation suivantes en vue de leur développement professionnel ?', 'qcm', [1fe6ce51-f0e4-4f5e-a881-add3191a91f7, a5e08abb-f96f-4620-a677-73583acc01c0, a3ca5111-0dc2-4af7-b8ea-a3f4c5c4c2c7, 5855962b-20c8-4d86-9314-71f1f95d5ec9, 9c750739-63f8-4f3a-8133-d1991891223e, c79ccd55-2ab9-425e-a160-6e2ef47fd4b4, b5828eb9-97c5-49d4-b545-71fa9b62b2e9, 35db326b-5663-411b-aa8f-84c12ff6e79e]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (041fe3f8-9931-40e9-ba80-5853cf1c48f5, 51, 'WORKERS', 'Est-ce que XXX mesure le pourcentage de travailleur·euses ayant bénéficié d''une formation au cours des 12 derniers mois ?
Si oui, veuillez préciser ce pourcentage.', '%', [6300bbb4-9821-48dc-b7a8-7074e8d371ac, 84e9be6e-e68e-460a-8d0d-0e3f717b570d, 62836608-dacf-4fc3-84e2-f2321cbe0a30, a5754cc3-33a0-4b11-9a46-175fc446d4d6, cca40e55-41b5-487c-ab0a-b8b6122c88e0, d01218bd-6bb0-485a-91b7-9e4261b665f5, eb43370d-336a-43c7-9518-4a9d8679f852]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (1f05d335-763e-49b4-8a3f-d6f24440a19d, 52, 'WORKERS', 'Quel est le montant total des dépenses consacrées à la formation des travailleur·euses au cours de la dernière année fiscale ?', 'qcm', [146757be-f555-48a1-b29f-5d58f05d8368, 74489f62-b857-4b5f-ae7f-17820adcfa60, 6cf642c6-6c84-49ff-975a-aae96d3b3030]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (6229da9f-be2a-47df-b966-57189589a2e7, 53, 'WORKERS', 'Quel est le pourcentage de travailleur·euses ayant bénéficié d''une promotion interne au cours des 12 derniers mois ?', '%', [5a42f4d5-26db-4ddb-a610-5323ffc436c7, 2e193642-1997-4627-b51c-2a937fd7be55, 29431a76-cc0f-4f62-96dc-b4ead485f334, 8042fd6c-11fc-4e4e-9649-a150ae534c77, 86084bb9-7f9f-4857-b1ed-177588ff6025, 738d5593-0043-4cc4-b483-138282b98066]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (a4c3320f-5b0f-4e04-8c7b-0c24e8331d53, 54, 'WORKERS', 'Comment est-ce que XXX engage et responsabilise les travailleur·euses ?', 'qcm', [14175aad-a5e8-4b03-8ca3-328178ecc22e, 67af852f-3231-456a-8809-eaed7f34795b, e374e087-aaf3-4643-b949-a45c37d4f7e9, c4262b1a-bd15-4240-80cb-4694bb35ce10, 96e96eba-296f-462c-b547-f4c777f83260]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (2da33190-ea47-4e71-8f6c-f563e83e5f6c, 55, 'WORKERS', 'Lesquelles des affirmations suivantes sont vraies en ce qui concerne la satisfaction et/ou l''engagement des travailleur·euses au sein de XXX ?', 'qcm', [e15cc1d7-0e62-4840-b6f1-47b30e823bc4, c5b0b248-16d4-475f-9e05-6acbc4706803, 8c041d17-d6be-494f-ad42-ad79215e766d, 0792e5af-ef92-45a9-a442-f13a397bad08, cca23c4a-4a46-4b1c-b985-60f583a8d385, 00afa007-844b-4715-bb3e-c2fa0a97820e, 856fdd6a-4835-4763-86e9-22f54afbe119]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (0dab4b50-4a2a-4ada-ac38-88f419a513ec, 56, 'WORKERS', 'Quel est le pourcentage équivalent du chiffre d''affaires distribué aux travailleur·euses sous forme de prime au cours du dernier exercice fiscal ?', '%', [9aa60d3c-e0f5-4afd-aa0a-689554774c57, 59630b68-0c64-4568-aba7-5f608ee8109c, 350224be-5866-4cee-9f90-e46272e920a3, 7580c94d-7d17-4181-97e6-25aa714a6bd4, 9849b4ab-fc15-4bfd-aebb-36868ed4e7b6, c1b5a28f-71ef-41f5-8590-973825f7d61b]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (67ebe51a-bae0-46c6-92d5-9d858795a491, 57, 'WORKERS', 'Quel est le pourcentage de travailleur·euses ayant bénéficié d''une prime au cours du dernier exercice fiscal ?', '%', [bc7e4212-de21-4bdd-8b70-ae5fd7b07781, eefd2d44-364a-4a28-8d55-e2a9552a1d49, 4fc6613e-9361-4d0e-8601-d44d6055d69a, 545a2b74-dd91-41f4-9d7f-005a8b05e418, 855c75f8-cc6a-41b7-aed5-cb1d7d85840d, f13e9661-d8eb-4dba-98d9-0e2368eb9edf]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (8d60ef88-8108-4db2-9d64-f3bfc4ebec2c, 58, 'WORKERS', 'Quel est le pourcentage de vos travailleur·euses qui sont "Satisfait·es" ou "Engagé·es" ?', '%', [f2954ff4-74ac-455c-9073-43c631dcba45, bfee3894-1008-4b04-a6b8-796a06a3539c, 470f70b4-0e54-47ec-b7b1-5607719663c7, 0e786898-ed7e-4d58-8b10-6ebd50553754, 660cc076-d615-4fb7-b9e5-340e5bc06f96, 2274e087-518d-4ee2-9003-dc894e45647b]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (31f12815-584e-4a12-9ed7-692392572155, 59, 'WORKERS', 'Quel est le **turn-over** en pourcentage de XXX ?
(Sur l''année fiscale précédente, diviser le nombre de départs d''employés (volontaires ou non) par l''effectif moyen de l''entreprise, puis multiplier le résultat par 100 pour obtenir un pourcentage)', 'pourcentage', [30fe1e28-8a0b-46e3-a237-c277e5ca2264, c38e291b-a598-4e42-93e8-675c5e8a93a3, 0ce67dd2-ad0a-4ef2-9fae-8fc0fd96d184, 690eb42d-0d49-489c-86b1-20c83b87f144, 7c77b5f3-239f-4ae8-bd6c-1ab6a5fbc853, 82995f14-8200-4926-a197-53607a983f6b, 81701791-842e-4eb4-91b4-239e183966b4]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (d5cacb51-dd68-4da5-94a0-d3bf4a27921e, 60, 'ALL', 'Comment XXX s''implique-t-elle dans des projets sociaux ?', 'qcm', [5ffcc391-797e-408d-8f88-45ce65cdc8ee, b59f7ab4-87c6-4cae-a0ce-a8bda11b3151, 4f12d52c-264f-47ba-883b-f7947ec56f26, 49ed51f7-405d-4042-938f-408f1228b8e2, 2258b6aa-281d-4238-bd01-0993c826fd23, 005ffad4-20dc-46e4-a589-71c16ff23b57, c69f3f93-c9b2-4797-8d99-0dbb8007925f, 57979047-dd97-4d8e-8143-4a1875b1a0aa, 2e400588-783a-4859-88d5-d5ab48dcf37e, 0b989d85-8cb9-4d70-8e18-c00dcc56c209]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (0dd9d446-0995-4837-96ba-d43d9b13e0a6, 61, 'ALL', 'Est-ce que XXX monitore régulièrement les heures consacrées à l''engagement social ? ', 'qcm', [3748f987-a894-43f6-90c0-99c48d97f262, ecf6e3ea-38a2-4679-accf-3dbf5daacf60, a585ff7b-f443-4da6-baf6-be1ae437b257]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (47f61e66-8478-4843-b22c-4e6fdabf808b, 62, 'ALL', 'Comment XXX aborde-t-elle la philanthropie ?', 'qcm', [4566b9a8-fffe-4013-8b5a-7dc729c7e453, 8b9927b3-0ea1-490b-8da3-aa9c9c816113, 1b1c7114-04a9-4280-acc1-c70256e3e667, 76729c90-a4d6-4100-b182-46d882179be9, 383f70b7-df1e-4403-8a16-525d79d77e3c, b15e91f3-9589-4027-a997-8e559ad92a12, 7b631279-c5cd-4204-845e-d372b39bd17b, d6fb00cc-f0c4-4df8-ad0a-58fe5730e502, 9fe34371-f744-4856-bf25-98860608b30f, 4dd0e0cd-b343-4ce2-832e-4e8ce0902511, 1903faa6-0a7f-49a9-8d00-00e6d990c3a3]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (df750a9b-28dc-41a0-a4cc-90bf70b3fce7, 63, 'ALL', 'Quel est le pourcentage du chiffre d''affaires distribué à titre philanthropique au cours du dernier exercice fiscal ?', '%', [25754890-9c66-499b-aac9-f846b13b52c9, ef6ffb32-d1f1-46d5-b651-7e2666d30fef, 421f8f53-d6fd-4d70-afa8-7fb21963780d, 49f0549a-c307-41de-91c2-83fbc58dbb2a, c392b0b7-5050-480b-b9ba-befdac64fcfc]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (d9e09b69-16e7-4997-b43e-d8956a211ec7, 64, 'ALL', 'Laquelle de ces options décrit le mieux la structure de gouvernance de XXX ? ', 'qcm', [9f088963-bbe9-4eba-9cfe-664a2e425617, 17dc62fb-5f35-485e-9ff9-c3fde43bf9fe, 8fe86a51-3a67-47bd-8365-62e0281ec9ab]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (6a2f3b48-149f-4680-b131-3695f5758f2b, 65, 'ALL', 'Le conseil d''administration de XXX dispose-t-il de sièges avec droit de vote représentant :', 'qcm', [2e23e295-9ac7-4090-9898-a8353b505355, 837ab0d7-6b53-4fee-b612-ffcdccf4ec05, bb19d364-d675-4b6e-99b6-36327fef729a, ef092b89-89e8-4512-8d9a-2c83481895d4, ab1e42bb-5101-49c5-a35f-316de22ab19f]);
INSERT INTO app.questions (id, index_question, template, value, type_response) VALUES (6443326d-fa9a-40b5-973a-0e9b4ae66d68, 66, 'ALL', 'Combien de membres compte votre conseil d''administration au total ? ', 'question ouverte');
INSERT INTO app.questions (id, index_question, template, value, type_response) VALUES (269eedf4-e6d4-49bd-8b8a-63112704e751, 67, 'ALL', 'Quel est le pourcentage d''administateur·rices indépendant·es au sein de votre conseil d''administration ?', 'question ouverte');
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (dfa66757-0606-4936-b37e-1a049dca1113, 68, 'ALL', 'Quel est le pourcentage des membres de votre conseil d''administration qui s''identifient comme femmes ? (Veuillez préciser le % précis dans les commentaires) ', '%', [77fd4e98-aad6-4946-8839-ef7f0607a05d, 51c92d1b-c0cc-4eb6-9e56-1cd6abc95046, bd3732ed-6d53-45ba-abc5-d9e609548d20, a56fc416-726e-4de4-be49-e3e503dfc9f9, c8fcc7d2-4b78-4e81-9899-aea8e4bdd32b]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (f7daa828-62b0-4ec9-bf01-9f3052123003, 69, 'ALL', 'Tous·tes les membres du conseil d''administration et de la direction remplissent-ils·elles un questionnaire annuel sur les conflits d''intérêts ?', 'qcm', [49853385-4ad7-489a-8c0b-3c729b1bf01a, 96ea6bc5-70a2-4d70-9c56-623dd1e6331f, fdc08d4d-5905-4359-80cc-304ad695c96b]);
INSERT INTO app.questions (id, index_question, template, value, type_response) VALUES (96e514c5-4371-4152-bcee-73799f3e2eca, 70, 'ALL', 'Combien de réunions du conseil d''administration avez-vous tenues au cours des 12 derniers mois ?', 'question ouverte');
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (dafed077-3a06-4c51-9932-cf9e5004ea11, 71, 'ALL', 'Quel pourcentage des principaux fournisseurs (représentant au moins 80 % des dépenses) fait l’objet d’audits ou contrôles annuels d’assurance qualité ?', '%', [35b1e15f-8ae3-4164-b309-d9276c7ab54a, 7c96fdaa-fcdc-41ec-a815-5792079e752d, 1cf627e5-4afe-47af-8f67-48e636c6782a, aa4636e8-a4aa-43bb-bce4-2f160fe8d8de, 74a2d8ab-4c36-4e5a-89dd-a8c9589654b2, 52967aa4-9eda-434d-8123-dbb06e0cac1c]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (8e0633c5-91d8-4321-b4c9-8f22abca96f3, 72, 'ALL', 'Parmi les initiatives suivantes, quelles sont celles qui ont été mises en oeuvre par XXX pour atténuer les risques Environnementaux, Sociaux et de Gouvernance (ESG) au sein de sa chaîne d''approvisionnement ? ', 'qcm', [af8fcabf-b52b-43d3-adb4-4b4bb7fb5cc1, cf53b90d-9362-4f2d-a239-1a337e836bd6, ebd4b40e-ef18-4294-aa16-0753c70c83c2, 5167947e-21b4-447b-8309-c27b63c80fde, cc25a4fe-5d70-49ef-b239-86fc3bd57d1a, 3f62ebbe-dbc0-4c0c-bd75-d6fd65d1674c, 3b304b5c-d1fd-4409-a05d-10f52565d6a6]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (02c8d1f3-f85c-44ed-8cf4-305fdad8a8d6, 73, 'ALL', 'XXX met-elle en place une ou plusieurs des actions suivantes pour gérer la valeur qu''elle apporte à ses client·es ou consommateur·rices ? ', 'qcm', [2bac05d8-f133-4128-b7b8-3183d7d975d6, 567c3a3e-3320-49ff-9916-f25bf45fe7a9, 20311970-e230-4305-af0f-37762d5e1d9f, 746095c1-ce8e-454c-a9b4-4068ab812b0f, c99cc8bd-32fb-45c8-b5f5-2d051a397c9d, e3fd9036-ef8b-498b-a929-f3eb5d366392, 72dda6bd-c0fb-4179-8152-9601020db592, fe55add1-7cde-4e08-a841-f3dcc6d6b127, 94974c61-cea4-4f74-95fd-8026dc152050]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (d640b03b-5a6c-445c-8cd3-ef5d01cf1b49, 74, 'ALL', 'Comment XXX intègre-t-elle les performances sociales et environnementales dans son processus décisionnel ?', 'qcm', [347f31d3-c2b9-4cb7-a086-1fe6a01ea8b9, 3fe6de76-5be2-4794-b21e-7b4d502fd1fc, 927938f8-6d7a-407c-b419-d5562fef3dca, 8a6b1be4-2064-4daf-a9bb-899de64c2a95, 08901678-d660-49be-b16c-2cdc9f1057e1, b78aaf16-353e-4c21-b8fb-e89e79c9007f]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (28854c41-695c-4c46-8c4d-d1bbbb07c5c5, 75, 'ALL', 'Avez-vous une mission formelle et écrite qui comprend l''un des élements suivants ?
Une déclaration de mission formelle et écrite de l''entreprise est une déclaration publique ou formellement partagée avec les travailleur·euses de l''entreprise. ', 'qcm', [45113974-f9f0-48b1-ad4d-200fa3065afe, 51c61beb-09d0-4e47-bf84-2e5b5de8c9a1, 543002e0-c307-4225-af85-077601a92782, a05b2a2a-126e-4220-b393-2a4903d9f544, 570a44cc-ae9e-49fa-85b2-5f5c02dc6b5f, e3915b4f-6ed0-442b-8940-3d8b6c01a554]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (6def87f2-3b6e-4f26-9a1c-02cda92985dc, 76, 'ALL', 'Comment XXX intègre-t-elle les Objectifs de Développement Durables (**ODD**) dans sa stratégie globale et ses activités commerciales ?', 'qcm', [314d7804-1bf0-4eb1-bfe6-bbf4d9f893c0, c10a21ef-d470-4b62-b290-e46eb5b293da, d8c8f485-56a5-45a5-aa05-ce944b6db785, 5154a864-3800-4856-b751-3202738a278a, 91e8c53a-eb3b-441c-a29c-c2d98def7f97, c89a2e69-3952-43b0-bbf4-6234e584d98e]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (80105c0c-106c-4b58-b7c6-66c631125a9e, 77, 'ALL', 'Quelles sont les étapes suivantes de l''analyse de double matérialité de XXX que vous avez déjà mises en oeuvres ? ', 'qcm', [08609a0a-8060-49be-8787-faa4e01029a2, 51752a1c-51f7-4ea5-9761-ef33ce809084, d88005a2-7b47-4bfa-ad2a-4a127ed264eb, 93e4acea-0854-4ce4-b26b-80be84acf9cf, e9009f74-8547-415c-a33f-74f1cddc0846, 862f2a39-f313-4bf8-9bc8-879b5ad38206, c6e43730-9964-4543-be4d-bd386a0ac4a7, edbb3d2a-27e2-4003-88aa-9cc9a375b1a0, e5e55310-2ac5-45fb-8fa8-5b4e11777512, 85bc93f1-7468-43a2-8ebf-0690529733ef]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (3bba5992-b972-4116-929c-18db157507a6, 78, 'ALL', 'Quelles informations sur son impact environnemental XXX rend-elle accessibles et transparentes ?', 'qcm', [1e0c80ce-1db6-4df2-8bda-05ad8c6a4847, e65cbfa7-870d-458d-849a-e7b65126ca94, 81462e0c-103e-4af1-b5aa-f1e800475e20, 3c211607-1e5d-4e27-b51c-7bf1cc3c15f4, 91c6b8a8-cfdb-4423-b27c-4987fd45dfbf, 51b40391-2acf-468a-8e57-2ad7048ba4ae, c80cb97b-ad9f-4af3-8f4a-482978518ed6, 4ec91b64-bb9c-4c9c-8a72-b468ca6cfce2, 3465c039-276c-4563-bcb4-fc3e6cad58fa]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (e8d6ff71-7931-4fcc-8532-4a13ca6b29c5, 79, 'WORKERS', 'Quelles informations sur son impact social XXX rend-elle accessibles et transparentes ?', 'qcm', [4a5e2969-8f31-4e54-8061-cc6b7fa8c1a5, fbd27d2b-d9ab-4da1-bd8b-4c99e90241f8, 86e5f5a2-a04b-4f35-a4ae-3d024ab1e20b, dc179ca1-9ad7-43b0-91c5-0ecbd84d36cf, fa04d9f4-73a9-4e36-89d8-94747f9b581f, 01797691-aa82-43f5-90fc-03fe1bfa9b65, c22e64b7-09e6-4eb2-bbed-b56364e2bcb4, 0cca3036-1878-4ea9-8591-6e0d41795a81, c85854a0-219b-4214-bd93-f4e52de9386c]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (a2b414e1-f83d-4836-a90e-1b554ab04615, 80, 'ALL', 'Quelles informations sur sa gouvernance XXX rend-elle accessibles et transparentes ?', 'qcm', [60d8a3ff-be01-49ca-8a79-e8d832b430b9, 9c9579fe-4217-45b3-aa51-51030b1c3b7c, 8e04ca88-f0ab-4626-b902-7f56c598d15c, aa27d7f1-b95a-43e0-8ac9-de2084c69631, 7f4dd2e3-6d15-40dd-b518-c88beed13366, 268c6dd3-88de-422c-96f2-7965da53b18b, 57aa4968-470d-4267-a4f5-5ee026cadb33, dd2eb117-69ac-4024-bd9f-2f968d523208, 7eb69404-6949-4789-8d8f-426500fec195, 535d920a-749a-4573-a905-d12ddded8bba]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (b183477c-5326-476c-b26f-d16412046635, 81, 'ALL', '
Quelles actions XXX a-t-elle mises en place pour garantir la qualité de son rapport d''impact ?', 'qcm', [e8648cbd-2ff5-4fa3-baa8-44ef2aadd4d8, d3bd7d11-0220-4476-99c7-1d14be4a2d93, e2092c4b-fc23-43d6-ac0e-6f1950b97bf0, 86074d11-6e54-406a-9465-1e474807f7fb, 252c7155-f487-4aa7-943d-adab7d4a0580]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (4551777d-7dc2-481b-9330-adaa812dc83c, 82, 'ALL', 'Quelle est l''approche de XXX en matière de formalisation de ses engagements : avez-vous écrit et partagé en interne les politiques suivantes ? ', 'qcm', [471a9615-2b66-4938-935b-42adbefcb53f, 2fcedb12-70d2-40d5-9619-3f567a57edac, 6488ad41-d6db-4036-a02e-6b7471d80e83, e39a3a98-5f5c-4273-b0ad-950a9c323803, 62226db7-0715-470d-8028-48463462bb61, 2c94d455-34ae-4ab7-9f6c-01c8a1f1815f, a806c032-f8d5-4d39-9afc-cabfedd2d341, c94141ff-5abf-4101-b701-87145cfdd440, ca2c6221-cb96-438e-b149-f3cc6ce45df1, 6cd6c4d2-6bc0-4b7a-a4c2-b37c35d67f21, d2143627-4762-4d7f-923f-42061b271264, 89c760c3-6fe6-4966-ab57-dd0a221aa867, 2487d1a7-8c3d-4a49-a352-3446556199e7]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (28bb5725-e3a5-4295-a0b0-cd98089b5518, 83, 'ALL', 'Le programme de lutte contre la corruption de XXX inclut-il un ou plusieurs des éléments suivants ? ', 'qcm', [b36a3657-de88-4077-b440-4047eb97705d, f9168822-5858-4dc5-bd85-943cc3c144e0, 801dd41b-ce2d-4e2c-a47a-e5bab12dfa52, 55ede1db-9e1f-484c-9656-81d2d3ee6b40, b0422232-4f28-4461-b573-0c7b919f2d12, abc8815f-6419-4c5a-9101-83a841dc164f, 253d784c-234b-41ce-afab-79f09b128dfb, d2ee0009-d329-43fc-9fbf-33258296cf49]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (be486eea-919f-4759-904c-37ffd78a989f, 84, 'ALL', 'XXX a-t-elle été confrontée à un litige important au cours de l''année écoulée (Si oui, veuillez préciser)?', 'qcm', [5ce1f6f9-6579-4f87-827b-faa010049bce, f32f9931-066b-46f6-b4e7-9447213242c2, 9f1ba6d6-3d6f-4e42-b866-00eb07b01837, 2c8c9283-ee31-40ca-99dd-ea961b3113a7, 4ae2f248-9ed0-4085-875d-f0787ab30f37, 36874394-0ebc-4a5a-ba84-4be7bb190435]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (c5b03176-fe43-4e6b-9ffe-ccfd0a941ed1, 85, 'ALL', 'XXX a-t-elle été confrontée à un problème environnemental majeur ou à un litige au cours de l''année écoulée (Si oui, veuillez préciser) ?', 'qcm', [859e4208-ebf7-441a-8132-90c56e476e86, cc9355a2-b7b1-4eb5-9690-5bf85bcea0ee]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (186b0080-f01a-4f96-a7e0-823048fd80cd, 86, 'WORKERS', 'Parmi les initiatives suivantes, laquelle ou lesquelles ont été mises en œuvre pour assurer la protection des données ?', 'qcm', [7ceec756-9915-4390-bfa2-0e8307d0ad2a, b4f657d6-d665-44cd-a165-d4de7645c7c8, 2c4755fe-5b6d-477b-b307-8b782def86b3, bfc1209f-b740-4bb1-be41-4517b7c97fc1, 7ded84c0-8545-40fa-8b72-3f893695504d, fd39a881-8128-40cc-997e-f1d8dd2cebf4, 52a91cdf-cd67-453f-8b6b-5bd3b2355bec]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (64ea519a-a0e1-4a79-bffc-62a089acf718, 87, 'ALL', 'Laquelle de ces propositions décrit le mieux l’état de votre politique de protection de la vie privée des employé·es et client·es ?', 'qcm', [4860c811-9ead-42e6-ac4c-4094ab4a24ae, 1317fb61-0e21-4ca7-8cde-bc0b37db2c78, 793664ee-c228-45e0-aafb-731adaa19ae4, 80d0b175-991f-4d98-b000-041d7bbdf43c, e2008e92-ad3a-45c2-b89a-1fb3b120dfbe]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (d1007c01-50f6-4a2d-b09c-ba9592126e98, 88, 'ALL', 'XXX respecte-t-elle toutes les obligations spécifiques du RGPD en ce qui concerne la collecte, l''utilisation et la protection des adresses électroniques et des données acquises par le biais de son site web. ?', 'qcm', [c68ad110-1e0b-4bdc-9399-987e19c54e5a, ab49d542-9a0a-4c1d-8278-1400c907d23d, 09c398d8-608b-4d2d-820f-a2af236b6448]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (d60fb541-662d-4609-96db-9d728d39c3a5, 89, 'ALL', 'Quel est le pourcentage de vos produits ou services ou pratiques durables qui ont été contrôlés et certifiés par un organisme d''accréditation axé sur la qualité ou le développement durable ? (ex : Fairtrade, BIO, Ecovadis, Ethibel, BDO etc)', '%', [4a1484b7-1ce8-4394-8ba7-b5cd97d28a3b, 33da04b8-04d4-46f8-ae3e-f0e682aee07e, 6aab36b8-9fc0-48ae-884c-5b6f5e44ad26, 21f41180-3c93-4459-933c-6a9a1eb0d703, d32398db-b666-48de-984e-9a1d3d5a84cd, 3d66904d-d2c8-47d1-b407-4188667b2240, dfa214b7-4601-4521-8495-4eeb133eb9dc]);
INSERT INTO app.questions (id, index_question, template, value, type_response, choices) VALUES (dd2847e2-b6f2-4d17-8a2e-247f3ee74906, 90, 'ALL', 'XXX a-t-elle obtenu une ou plusieurs certiifcations attestant ses efforts en matière de transition durable ? ', 'qcm', [2cb7f154-1bdf-4c4d-8dd9-fe83af07a638, e5c56d0f-8f8d-4398-99fc-57d7edae23ca, f0dc87ea-a24f-4081-b057-5247b7350c6e, 6922e321-189f-4623-88a2-8599970186ef, 51ff2d70-4c4a-4a81-ba85-05edb5aa276d, 5c93acd0-635a-477a-ac2d-e0e220e43677, 244d4e88-91a1-48cf-a8eb-84808d2b9265]);

-- Insert sub_challenges
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (61ea732f-c3bb-4dd3-a219-6bde17c9eaea, 1, 'GESTION DE L''ENERGIE', [b97cad22-5663-4465-8376-22aa69cc582b, fc4177a9-bfd8-4a4b-8d44-fc2a9d1909b1, e83569e0-0035-4015-a162-f54998f30a67, 020125df-3153-4a25-a4d9-29487badf404, 51c8907b-ad07-42bc-ada4-61acd4dc2172]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (895e9ba4-dde5-402e-b67f-e982ff6a9c01, 2, 'EMPREINTE CARBONE', [d870a33c-b9ae-450e-8ec7-90ed32110dba, ca81bec4-e57d-470c-afc5-12568d639139, ee2f05e4-3309-4518-9311-954ac3c5fb9b, 4daf4517-0d1c-470d-b4b2-113143111773, 282ade19-d0ef-4185-a79f-2bdcf3ddc62f, e43bcb4f-47a8-4149-8b67-478e371ec459, e6bd41c3-db6c-407c-8404-2e924e4be0b2, 89513142-f5af-4f85-9d64-7734a8a19d6c, ed3db903-6dde-4f8f-9a2b-0a97aa998bef, 87fd8182-1d83-441d-9e9a-f8c7debd7243, f43c3a5c-3536-4893-9bd8-293ae46cd86e]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (f88ad8b3-5358-4126-bce4-7892bb608da8, 1, 'EAU', [ad0bd53d-3d92-4d8c-8e52-7041f5602858, 1bd6184d-57b4-4de2-aa6e-c3147fce6f09, 97e947fe-541a-4688-bcb3-2ef719d9eea0, 730778da-2198-43fc-814f-32db39f06416, 5c33265f-b12f-4cda-a25d-87f8e7ac1359]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (153b4a44-09eb-4dd0-bad0-e0c9b6e08ce6, 2, 'MATIERES PREMIERES ET FOURNITURES', [441a56d0-0d05-4278-8d32-0c061fb1ff8d, 0da6eaa9-9da6-47ac-8618-36931ff4b556, d25ee249-1452-4c8d-a99c-ab64297a6a46]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (586629ee-7255-4975-abe5-feff3440ab3e, 1, 'DÉCHETS', [82cfa8be-93e6-49a7-9e72-2f3b8bcad788, b26996f9-daea-45be-b789-45d8a2a7c65c, 143504a9-e522-4e7b-9296-a5893843f5a5, 1b76b71c-e65d-43aa-9ca9-dc9db31d9c22, d52786c5-0eb1-477c-8a94-d501756e0cfb, 6bebf7fc-9eb5-4926-a2fb-726a1cc10b08]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (914edc70-f876-4ed1-bd2b-a042d6e8b11e, 1, 'ÉCOSYSTÈMES ET BIODIVERSITÉ', [4761732e-7397-4aed-9178-9aaa9b2ad63b, b51a9007-ef66-453e-afe7-7c363334402e]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (0f3a2141-2928-4b9f-9463-0dfb4f977437, 1, 'INCLUSION ET EQUITE', [764533ba-cf51-4ae3-9947-e346436e31bf, 69be1067-51a9-4a22-bfe5-098d5db64028, a3972cf9-35cb-4921-bf67-6fa4f9a40fc7, a50f4cd7-5fe5-49e1-b8d0-2633dc528950, 54aa5661-e3b1-497c-9f87-5839cc71c788, 0d5245d9-8181-43b8-9ca6-c8012e5bccdd]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (f00988ae-c148-479e-b5de-6fea384c6fbd, 2, 'DIVERSITE', [97d6f369-4137-44f7-bfa1-e68ff637bd2a, 7a8ccbbe-fbdc-470e-a3bb-ebe170e54b18, 2170de86-a872-4624-a7eb-83523392d56d, 8407f8fd-3f9a-483c-85d7-f6f1166abb71, da734b4c-f8d5-4343-a0a6-2355060311cc]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (1c42b410-0279-45d9-b47e-233efc05daa6, 1, 'SECURITE AU TRAVAIL', [ad83d85c-86c5-459f-8997-67696767ca92, f4f50fe2-7c93-49c1-b175-3f7747845b86]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (c29f2e9d-5921-4d36-b4e0-656a2964af64, 2, 'SANTÉ ET BIEN-ÊTRE', [755fd48d-b200-437b-8c83-820dc7d15d8a, 74fbddf2-1453-4d65-b3f2-ae6dc0b3156a]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (5b796a33-f309-40bd-89c1-1d6f0349ca27, 1, 'DEVELOPPEMENT DES COMPETENCES', [58c7bdf1-34d7-418d-851f-bff0d4df03e1, 5fcc19c1-5b54-42f6-8b4b-de5072a95ab0, 041fe3f8-9931-40e9-ba80-5853cf1c48f5, 1f05d335-763e-49b4-8a3f-d6f24440a19d, 6229da9f-be2a-47df-b966-57189589a2e7, a4c3320f-5b0f-4e04-8c7b-0c24e8331d53]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (ba230bc4-b180-4e97-ae49-5bb991eed27f, 2, 'ENGAGEMENT ET SATISFACTION', [2da33190-ea47-4e71-8f6c-f563e83e5f6c, 0dab4b50-4a2a-4ada-ac38-88f419a513ec, 67ebe51a-bae0-46c6-92d5-9d858795a491, 8d60ef88-8108-4db2-9d64-f3bfc4ebec2c, 31f12815-584e-4a12-9ed7-692392572155]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (1466c0b4-75b7-4705-9efd-ffdfb97f1925, 1, 'ENGAGEMENT SOCIAL', [d5cacb51-dd68-4da5-94a0-d3bf4a27921e, 0dd9d446-0995-4837-96ba-d43d9b13e0a6]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (ec679e6f-52ff-4352-a4e4-aea455ee0096, 2, 'PHILANTHROPIE', [47f61e66-8478-4843-b22c-4e6fdabf808b, df750a9b-28dc-41a0-a4cc-90bf70b3fce7]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (33344627-ae3b-4ce6-b3a6-54d32f116efb, 1, 'STRUCTURE DE GOUVERNANCE', [d9e09b69-16e7-4997-b43e-d8956a211ec7, 6a2f3b48-149f-4680-b131-3695f5758f2b, 6443326d-fa9a-40b5-973a-0e9b4ae66d68, 269eedf4-e6d4-49bd-8b8a-63112704e751, dfa66757-0606-4936-b37e-1a049dca1113, f7daa828-62b0-4ec9-bf01-9f3052123003, 96e514c5-4371-4152-bcee-73799f3e2eca]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (b7692f9b-543e-4f90-9e9e-a2c23dac6e74, 2, 'INTEGRATION DES PARTIES PRENANTES', [dafed077-3a06-4c51-9932-cf9e5004ea11, 8e0633c5-91d8-4321-b4c9-8f22abca96f3, 02c8d1f3-f85c-44ed-8cf4-305fdad8a8d6, d640b03b-5a6c-445c-8cd3-ef5d01cf1b49]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (c11be3e5-c64b-454f-ae64-7438fcc8e6aa, 3, 'GESTION DURABLE', [28854c41-695c-4c46-8c4d-d1bbbb07c5c5, 6def87f2-3b6e-4f26-9a1c-02cda92985dc, 80105c0c-106c-4b58-b7c6-66c631125a9e]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (85f13fb5-1f3a-40be-8015-d3e17e162a89, 4, 'TRANSPARENCE', [3bba5992-b972-4116-929c-18db157507a6, e8d6ff71-7931-4fcc-8532-4a13ca6b29c5, a2b414e1-f83d-4836-a90e-1b554ab04615, b183477c-5326-476c-b26f-d16412046635]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (f176f8d1-22d5-4b17-88d4-556928fae7f6, 1, 'FORMALISATION DES PRATIQUES', [4551777d-7dc2-481b-9330-adaa812dc83c]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (8a4d1b2b-dac3-4eb0-9d50-111f42f10024, 2, 'LUTTE CONTRE LA CORRUPTION FINANCIÈRE', [28bb5725-e3a5-4295-a0b0-cd98089b5518]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (161627aa-a37f-4c1b-afda-a2d2b45941b1, 3, 'DIVULGATION DES LITIGES', [be486eea-919f-4759-904c-37ffd78a989f, c5b03176-fe43-4e6b-9ffe-ccfd0a941ed1, 022c73c7-6cce-4a1d-937a-4bf73f364368]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (9633a1d1-545e-472d-8a3a-1cbf41a9d8f4, 1, 'SECURITE DES DONNEES', [186b0080-f01a-4f96-a7e0-823048fd80cd]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (f946769a-2ed8-475a-9b31-a06a71196a81, 2, 'PROTECTION DE LA VIE PRIVEE', [64ea519a-a0e1-4a79-bffc-62a089acf718, d1007c01-50f6-4a2d-b09c-ba9592126e98]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (191a34e2-9359-4d9c-a99a-81b3e6496243, 1, 'CERTIFICATIONS D''UN PRODUIT, D''UN SERVICE OU D''UNE PRATIQUE', [d60fb541-662d-4609-96db-9d728d39c3a5]);
INSERT INTO app.sub_challenges (id, index_sub_challenge, value, questions)
VALUES (4066c27e-9d9b-4014-b271-35517643c287, 2, 'CERTIFICATIONS DE L''ENTREPRISE', [dd2847e2-b6f2-4d17-8a2e-247f3ee74906]);

-- Insert Challenges
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (084fd444-a20a-4224-95f6-09c393f56adc, 1, 'ENERGIE & CARBONE', 'b5cdbf', [61ea732f-c3bb-4dd3-a219-6bde17c9eaea, 895e9ba4-dde5-402e-b67f-e982ff6a9c01]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (6eecf85e-6033-40fd-ac9c-f4b74bf045a1, 2, 'EAU, MATIERES PREMIERES ET FOURNITURES', 'b5cdbf', [f88ad8b3-5358-4126-bce4-7892bb608da8, 153b4a44-09eb-4dd0-bad0-e0c9b6e08ce6]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (e0b6f5cd-058d-4b5d-b0fd-4698cc93ef93, 3, 'DÉCHETS', 'b5cdbf', [586629ee-7255-4975-abe5-feff3440ab3e]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (968fe055-33bf-40d7-856f-76d4ba8bf463, 4, 'ÉCOSYSTÈMES ET BIODIVERSITÉ', 'b5cdbf', [914edc70-f876-4ed1-bd2b-a042d6e8b11e]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (b853551f-1ebf-4295-9af1-2626a51f2e2c, 5, 'DIVERSITE, INCLUSION ET EQUITE', 'dfd4fb', [0f3a2141-2928-4b9f-9463-0dfb4f977437, f00988ae-c148-479e-b5de-6fea384c6fbd]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (a5f46dac-05f0-4361-9a89-4470ea18732c, 6, 'SÉCURITÉ, SANTÉ & BIEN-ÊTRE', 'dfd4fb', [1c42b410-0279-45d9-b47e-233efc05daa6, c29f2e9d-5921-4d36-b4e0-656a2964af64]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (27085b13-730d-4eee-8bd8-592342654e57, 7, 'EMPLOI ET PRATIQUES DE TRAVAIL', 'dfd4fb', [5b796a33-f309-40bd-89c1-1d6f0349ca27, ba230bc4-b180-4e97-ae49-5bb991eed27f]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (f00e8e04-d500-4c9d-ac02-ae4f6b1f5679, 8, 'ENGAGEMENT CIVIQUE', 'dfd4fb', [1466c0b4-75b7-4705-9efd-ffdfb97f1925, ec679e6f-52ff-4352-a4e4-aea455ee0096]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (0b4415a3-d6f9-43f6-80de-f6ad86c443dd, 9, 'CONDUITE DES AFFAIRES', 'fde791', [33344627-ae3b-4ce6-b3a6-54d32f116efb, b7692f9b-543e-4f90-9e9e-a2c23dac6e74, c11be3e5-c64b-454f-ae64-7438fcc8e6aa, 85f13fb5-1f3a-40be-8015-d3e17e162a89]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (ba42dd01-aefd-47e9-bd94-4a8e646c99a7, 10, 'ETHIQUE DES AFFAIRES', 'fde791', [f176f8d1-22d5-4b17-88d4-556928fae7f6, 8a4d1b2b-dac3-4eb0-9d50-111f42f10024, 161627aa-a37f-4c1b-afda-a2d2b45941b1]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (476e77a8-6b39-4f9f-ac25-8a6261fa1b56, 11, 'PROTECTION  DES DONNEES', 'fde791', [9633a1d1-545e-472d-8a3a-1cbf41a9d8f4, f946769a-2ed8-475a-9b31-a06a71196a81]);
INSERT INTO app.challenges (id, index_challenge, value, color, sub_challenges) VALUES (34579f88-7db1-48cc-b955-5b2600a72b6f, 12, 'CERTIFICATIONS', 'fde791', [191a34e2-9359-4d9c-a99a-81b3e6496243, 4066c27e-9d9b-4014-b271-35517643c287]);


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
INSERT INTO app.client_information (id_user, number_workers, owned_facility, service_or_product, company_name)
VALUES (550e8400-e29b-41d4-a716-446655440020, 10, False, 'service', 'Client Open CompanyName');

INSERT INTO app.client_information (id_user, number_workers, owned_facility, service_or_product, company_name)
VALUES (550e8400-e29b-41d4-a716-446655440021, 0, False, 'produit', 'Client Validation CompanyName');

INSERT INTO app.client_information (id_user, number_workers, owned_facility, service_or_product, company_name)
VALUES (550e8400-e29b-41d4-a716-446655440022, 1, True, 'service', 'Client Verified CompanyName');
