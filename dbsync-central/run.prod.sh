#!/bin/sh

apk update
apk upgrade
apk add bash

./init_eip.sh

cp -a $shared_dir/openmrs-eip/distribution/receiver/routes .

echo Starting DB sync Receiver...

java -jar -Dspring.profiles.active=receiver openmrs-eip-app.jar

#TMP CODE BELLOW
crond -f -l 8
