# Backend

## Install and Run

### Create virtual environment

#### On windows

```sh
python3 -m venv venv
venv\Scripts\activate
```

#### On linux

```sh
python3 -m venv venv
source venv/bin/activate
```

### Install dependencies

```sh
pip install -r requirements.txt
```

### Create in backend folder .env

```sh
touch .env
```

### Add database credentials in .env (example for localhost)

```text
DB_USER=cassandra
DB_PASSWORD=cassandra
DB_KEYSPACE=app
DB_HOST=localhost
DB_PORT=9042
SECRET_KEY_JWT=MY_SUPER_SECRET
```

### run server

```sh
python manage.py runserver
```


