#!/bin/sh

apk update
apk upgrade
apk add bash
apk add git
apk add maven

if test ! -f "openmrs-eip-app.jar"; then
  git clone https://github.com/FriendsInGlobalHealth/openmrs-eip.git
  cd openmrs-eip
  mvn clean install -DskipTests
  cp app/target/openmrs-eip-app-1.1-SNAPSHOT.jar ../openmrs-eip-app.jar
  cd ..
fi
