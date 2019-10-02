#!/bin/bash -x

WORK_DIR=$(dirname $0)

cd $WORK_DIR
export COMPOSE_PROJECT_NAME=fsp
export COMPOSE_FILE=es-cluster.yaml
docker-compose "$@"
cd -