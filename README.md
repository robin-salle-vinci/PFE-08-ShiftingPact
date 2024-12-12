# PFE-08-ShiftingPact

## Install and run backend

-> backend/README.md

## Install and run frontend

-> frontend/README.md

# Docker

## Instructions pour démarrer l'application

### Prérequis

- Docker
- Docker Compose

### Étapes pour démarrer

1. **Configurer les variables d'environnement** :

   - Créez un fichier `.env` dans le répertoire `backend/backend` et ajoutez les variables suivantes :

   ```env
   DB_USER=cassandra
   DB_PASSWORD=cassandra
   DB_KEYSPACE=app
   DB_HOST=cassandra
   DB_PORT=9042
   SECRET_KEY_JWT=my_secret_jwt
   ```

2. **Donnée les acces adminstrateur au script** :

   ```bash
   chmod +x ./cassandra-entrypoint.sh
   ```

3. **Démarrer les services** :
   ```bash
   docker-compose up -d
   ```

### Accéder à la page du frontend

- Une fois les services démarrés, accédez à la page du frontend via l'URL suivante : http://localhost:3000
