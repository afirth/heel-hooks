# @afirth 2018-11

.SHELLFLAGS := -eux -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
SHELL=/bin/bash
.SUFFIXES:

REPO_NAME ?= $(notdir $(CURDIR))

build:
	docker build --build-arg REPO_NAME=$(REPO_NAME) -t $(REPO_NAME):dev .

run:
	docker run -p 8080:8080 --rm $(REPO_NAME):dev

.PHONY: build run
