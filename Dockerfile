FROM python:3.7-alpine
LABEL maintainer "Dan Streeter <dan@danstreeter.co.uk>"

COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip && pip install -r /requirements.txt


RUN mkdir /app
COPY ./src/main.py /app/main.py
WORKDIR /app

CMD ["python", "-u", "main.py"]