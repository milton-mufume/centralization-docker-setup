#!/bin/sh

echo Starting DB sync Receiver...

echo "Starting notification manager appy"

nohup java -jar -Dspring.profiles.active=consumer -Duser.timezone="Africa/Maputo" notifications-manager.jar 2>&1 &

echo -n "NOTIFICATIONS MANAGER STARTED IN BACKGROUND"

echo Starting openmrs eip app...

java -jar -Dspring.profiles.active=receiver -Duser.timezone="Africa/Maputo" openmrs-eip-app.jar
