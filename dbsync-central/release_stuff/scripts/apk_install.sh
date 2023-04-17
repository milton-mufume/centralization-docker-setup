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
echo "Installing VIM"  | tee -a $LOG_DIR/apk_install.log
apk add vim
echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log
echo "Installing NANO"  | tee -a $LOG_DIR/apk_install.log
apk add nano
echo "-------------------------------------------------"  | tee -a $LOG_DIR/apk_install.log

echo "Installing OPENSSL"  | tee -a $LOG_DIR/apk_install.log
apk add openssl

echo "INSTALLING EXPECT" | tee -a $LOG_DIR/apk_install.log
apk add expect

echo "-------------- APK INSTALLATION FINISHED -------------"  | tee -a $LOG_DIR/apk_install.log

