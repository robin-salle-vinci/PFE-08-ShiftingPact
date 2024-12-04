FROM python:3.11

# Install Netcat (nc) to wait for the Cassandra service
RUN apt-get update && apt-get install -y netcat-openbsd

# Télécharger et installer dockerize
RUN curl -sSL https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz | tar -xzv && mv dockerize /usr/local/bin/


WORKDIR /usr/src/app

COPY . .

# # Script to wait for the Cassandra service
# RUN chmod +x /usr/src/app/wait-for-it.sh

# Install system dependencies
RUN apt-get update && apt-get install -y libev-dev

# Upgrade pip
RUN pip install --upgrade pip

# Install Python dependencies
RUN pip install dse-driver cassandra-driver
RUN pip install --no-cache-dir -r requirements.txt

# Expose necessary port
EXPOSE 8080

# Command to run the Django application
CMD ["sh", "-c", "dockerize -wait tcp://cassandra:9042 -timeout 60s python manage.py sync_cassandra && python manage.py runserver 0.0.0.0:8080"]