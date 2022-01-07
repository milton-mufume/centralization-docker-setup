#!/bin/sh
#This bash install all the necessary applications needed by the container

HOME_DIR=/home/eip
LOG_DIR=$HOME_DIR/shared/logs/apk

if [ -d "$LOG_DIR" ]; then
       echo "THE LOG DIR EXISTS" | tee -a $LOG_DIR/apk_install.log
else
       mkdir -p $LOG_DIR
       echo "THE LOG DIR WAS CREATED" | tee -a $LOG_DIR/apk_install.log
fi

echo "Updating OS"  | tee -a $LOG_DIR/apk_install.log
echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log
apk update
echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log
echo "Upgrading OS"  | tee -a $LOG_DIR/apk_install.log
apk upgrade
echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log
echo "Installing bash"
apk add bash
echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log
echo "Installing Git"  | tee -a $LOG_DIR/apk_install.log
apk add git
echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log
#echo "Installing Maven"  | tee -a $LOG_DIR/apk_install.log
#apk add maven
#echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log
#echo "TRYING TO INSTALL CURL" | tee -a $LOG_DIR/apk_install.log
#apk add curl
#echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log

#echo "TRYING TO INSTALL MUTT" | tee -a $LOG_DIR/apk_install.log
#apk add mutt
#echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log

#echo "TRYING TO INSTALL GIT" | tee -a $LOG_DIR/apk_install.log
#apk add git
#echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log

#echo "INSTALLING SSMPT" | tee -a $LOG_DIR/apk_install.log
#apk add ssmtp
#echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log

#echo "INSTALLING OPENSSH" | tee -a $LOG_DIR/apk_install.log
#apk add openssh
#echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log

#echo "INSTALLING EXPECT" | tee -a $LOG_DIR/apk_install.log
#apk add expect
#echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log
