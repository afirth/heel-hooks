#!/usr/bin/env bash

# replace variables in .yaml.tmpl files
# e.g. from cloudbuild `

sed 's/\{{ .Values.Name }}'"/$REPO_NAME/g"
sed 's/\{{ .Values.Project.ID }}'"/$PROJECT_ID/g"
sed 's/\{{ .Values.Port }}'"/$CONTAINER_PORT/g"
