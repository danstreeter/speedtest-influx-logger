FROM python:3.8.5-alpine
LABEL maintainer "Dan Streeter <dan@danstreeter.co.uk>"

COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip && pip install -r /requirements.txt


RUN mkdir /app
COPY ./speedtest_influx_logger/main.py /app/main.py

RUN adduser -D appuser && chown -R appuser: /app
USER appuser

WORKDIR /app

ENV PYTHONPATH=/app

CMD ["python", "-u", "main.py"]