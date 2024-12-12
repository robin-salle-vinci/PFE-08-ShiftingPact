FROM python:3.11

# Install Netcat (nc) to wait for the Cassandra service
RUN apt-get update && apt-get install -y netcat-openbsd

# Install dockerize
RUN curl -sSL https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz | tar -xzv && mv dockerize /usr/local/bin/

# Install bash
RUN apt-get install -y bash

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install system dependencies
RUN apt-get update && apt-get install -y libev-dev

# Upgrade pip
RUN pip install --upgrade pip

# Create and activate the virtual environment
RUN python3 -m venv /usr/src/app/venv

# Install Python dependencies in the virtual environment
RUN /usr/src/app/venv/bin/pip install --no-cache-dir -r requirements.txt

# Expose the port that the app will run on
EXPOSE 8000

# Use bash and activate the virtual environment
CMD ["bash", "-c", "source /usr/src/app/venv/bin/activate && dockerize -wait tcp://cassandra:9042 -timeout 120s && python manage.py runserver 0.0.0.0:8000"]
