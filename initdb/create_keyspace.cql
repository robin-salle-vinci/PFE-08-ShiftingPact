CREATE KEYSPACE IF NOT EXISTS app 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
