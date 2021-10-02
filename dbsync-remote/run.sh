#!/bin/sh

#apk update
#apk upgrade
#apk add bash

echo Starting DB sync Sender...

java -jar -Dspring.profiles.active=sender openmrs-eip-app.jar
