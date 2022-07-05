#!/bin/sh

apk update
apk upgrade
apk add bash

./init_eip.sh

cp -a openmrs-eip/distribution/sender/routes /user/local/dbsync/routes

echo Starting DB sync Sender...

java -jar -Dspring.profiles.active=sender openmrs-eip-app.jar
