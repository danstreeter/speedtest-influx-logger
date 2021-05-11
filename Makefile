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
export PYTHONPATH=./speedtest_influx_logger

.PHONY: clean build publish exports

build: clean
	pipenv run python -m pip install --upgrade --quiet setuptools wheel twine
	pipenv run python setup.py --quiet sdist bdist_wheel

publish: build
	pipenv run python -m twine check dist/*
	pipenv run python -m twine upload dist/*

clean:
	rm -r build dist *.egg-info || true

init:
	pipenv --python ${PYTHON_VERSION}
	pipenv install

start-db:
	docker-compose up -d influx

stop-db:
	docker-compose stop influx

exports:
export NODE_NAME=dev
export INFLUX_HOST=localhost
export INFLUX_PORT=8086
export INFLUX_USER=CHANGEME
export INFLUX_PASS=CHANGEME
export INFLUX_DB=internetspeed
export TEST_FREQUENCY=1

shell: exports
	pipenv shell

dev: exports
	pipenv run python speedtest_influx_logger/main.py

requirements:
	pipenv lock -r > requirements.txt