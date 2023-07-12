#!/bin/sh

echo Starting DB sync Receiver...

java -jar -Dspring.profiles.active=receiver -Duser.timezone="Africa/Maputo" openmrs-eip-app.jar
