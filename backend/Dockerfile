FROM python:3.9

WORKDIR /usr/src/app

COPY . .

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install django-cassandra-engine

EXPOSE 8080

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
