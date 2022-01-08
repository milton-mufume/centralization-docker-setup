#!/bin/sh

apt-get update
apt-get install -y curl
apt-get install -y vim 
apt-get install -y nano 
apt-get install -y expect

if test ! -f "/usr/local/tomcat/webapps/openmrs.war"; then
  curl -L https://downloads.sourceforge.net/project/openmrs/releases/OpenMRS_Platform_2.3.3/openmrs.war -o /usr/local/tomcat/webapps/openmrs.war
fi

./bin/install_opencr_cert.exp

./bin/catalina.sh run
