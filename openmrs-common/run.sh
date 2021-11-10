#!/bin/sh

apt-get update
apt-get install -y curl

if test ! -f "/usr/local/tomcat/webapps/openmrs.war"; then
  curl https://versaweb.dl.sourceforge.net/project/openmrs/releases/OpenMRS_Platform_2.3.3/openmrs.war -o /usr/local/tomcat/webapps/openmrs.war
fi

./bin/catalina.sh run
