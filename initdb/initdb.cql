CREATE KEYSPACE IF NOT EXISTS app 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

INSERT INTO app.user (id, username, password, role, id_info_client)
VALUES (uuid(), 'admin@gmail.com', 'adminpassword', 'admin', null);
INSERT INTO app.user (id, username, password, role, id_info_client)
VALUES (uuid(), 'client@gmail.com', 'clientpassword', 'client', 101);
