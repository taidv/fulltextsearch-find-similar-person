#!/bin/bash

WORK_DIR=$(dirname $0)

cd $WORK_DIR

# ./docker-ctl.sh up -d

# curl -X PUT "localhost:9200/_template/people?pretty" -H 'Content-Type: application/json' --data-binary @template.json
curl -X GET "localhost:9200/_template/people?pretty" -H 'Content-Type: application/json'
curl -X PUT "localhost:9200/people_linkedin/_bulk?pretty" -H 'Content-Type: application/json' --data-binary @init-data.json
curl -X GET "localhost:9200/people*/_search?pretty" -H 'Content-Type: application/json'
curl -X GET "localhost:9200/people_linkedin/_mapping?pretty" -H 'Content-Type: application/json'
curl -X DELETE "localhost:9200/people_linkedin?pretty" -H 'Content-Type: application/json'
curl -X GET "localhost:9200/people*/_search?pretty" -H 'Content-Type: application/json'
