# @afirth 2018-11

.SHELLFLAGS := -eux -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
SHELL=/bin/bash
.SUFFIXES:

REPO_NAME ?= $(notdir $(CURDIR))
PORT ?= 8080

all: build run

build:
	docker build --build-arg REPO_NAME=$(REPO_NAME) -t $(REPO_NAME):dev .

run:
	docker run \
		-e HTTP_ADDR=':$(PORT)' \
		-p $(PORT):$(PORT) \
		--rm $(REPO_NAME):dev

.PHONY: all build run
