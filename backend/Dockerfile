FROM python:3.11

# Install Netcat (nc) to wait for the Cassandra service
RUN apt-get update && apt-get install -y netcat-openbsd

# Install dockerize
RUN curl -sSL https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz | tar -xzv && mv dockerize /usr/local/bin/


WORKDIR /usr/src/app

COPY . .

# Install system dependencies
RUN apt-get update && apt-get install -y libev-dev

# Upgrade pip
RUN pip install --upgrade pip

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose necessary port
EXPOSE 8080

# Command to run the Django application
CMD ["sh", "-c", "dockerize -wait tcp://cassandra:9042 -timeout 120s  python manage.py runserver 0.0.0.0:8080 && python manage.py sync_cassandra"]
