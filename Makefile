PYTHON_VERSION := "3.8.5"
PIPENV := $(shell command -v pipenv 2> /dev/null)


ifndef PYTHON_VERSION
    $(error "Python version is not specified, please add in Makefile")
endif

ifndef PIPENV
    $(error "Pipenv is not installed! See README.md")
endif


.PHONY: init test dev run-like-prod lint requirements pipeline-dev

export PIPENV_IGNORE_VIRTUALENVS=1
export PYTHONPATH=./src

export NODE_NAME=dev
export INFLUX_HOST=localhost
export INFLUX_PORT=8086
export INFLUX_USER=CHANGEME
export INFLUX_PASS=CHANGEME
export INFLUX_DB=internetspeed
export TEST_FREQUENCY=1

init:
	pipenv --python ${PYTHON_VERSION}
	pipenv install

start-db:
	docker-compose up -d influx

stop-db:
	docker-compose stop influx

dev:
	pipenv run python src/main.py