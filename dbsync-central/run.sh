#!/bin/sh

apk update
apk upgrade
apk add bash

echo Starting DB sync Receiver...

java -jar -Dspring.profiles.active=receiver openmrs-eip-app.jar
