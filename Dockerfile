FROM python:3.11-slim-buster

WORKDIR /src

COPY ./analytics/requirements.txt requirements.txt

# Dependencies required for psycopg2
RUN apt update -y && apt install -y build-essential libpq-dev

RUN pip install -r requirements.txt

COPY ./analytics .

CMD python app.py