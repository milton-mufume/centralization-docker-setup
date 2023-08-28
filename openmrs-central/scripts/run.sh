#!/bin/sh

HOME_DIR="/usr/local/tomcat"
INSTALL_FINISHED_REPORT_FILE="$HOME_DIR/install_finished_report_file"

apt-get update
apt-get install -y curl
apt-get install -y vim 
apt-get install -y nano 
apt-get install -y expect

if test ! -f "/usr/local/tomcat/webapps/openmrs.war"; then
  curl -L https://downloads.sourceforge.net/project/openmrs/releases/OpenMRS_Platform_2.3.5/openmrs.war -o /usr/local/tomcat/webapps/openmrs.war
fi


if [ ! -f "$INSTALL_FINISHED_REPORT_FILE" ]; then
	$HOME_DIR/scripts/init.sh

	timestamp=`date +%Y-%m-%d_%H-%M-%S`
  	echo "Installation finished at $timestamp" >> $INSTALL_FINISHED_REPORT_FILE
fi

./bin/catalina.sh run
