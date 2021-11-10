#!/bin/sh

apt-get update
apt-get install -y curl

WAR_FILE="/usr/local/tomcat/webapps/openmrs.war"

if test ! -f "$WAR_FILE"; then
  curl https://versaweb.dl.sourceforge.net/project/openmrs/releases/OpenMRS_Platform_2.3.3/openmrs.war -o $WAR_FILE
fi

./bin/catalina.sh run
