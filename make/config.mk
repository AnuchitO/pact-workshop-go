SHELL = "/bin/bash"

export PATH := $(PWD)/pact/bin:$(PATH)
export PATH
export PROVIDER_NAME = GoUserService
export CONSUMER_NAME = GoAdminService
export PACT_DIR = $(PWD)/pacts
export LOG_DIR = $(PWD)/log
export PACT_BROKER_USERNAME = dXfltyFMgNOFZAxr8io9wJ37iUpY42M
export PACT_BROKER_PASSWORD = O5AIZWxelWbLvqMd8PkAVycBJh2Psyg1
export PACT_BROKER_PROTO = https
export PACT_BROKER_URL = test.pactflow.io
export VERSION_COMMIT?=$(shell git rev-parse HEAD)
export VERSION_BRANCH?=$(shell git rev-parse --abbrev-ref HEAD)
