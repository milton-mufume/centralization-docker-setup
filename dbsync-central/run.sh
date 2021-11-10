#!/bin/sh

apk update
apk upgrade
apk add bash

./init_eip.sh

cp -a openmrs-eip/distribution/receiver/routes /user/local/dbsync/routes

echo Starting DB sync Receiver...

java -jar -Dspring.profiles.active=receiver openmrs-eip-app.jar
