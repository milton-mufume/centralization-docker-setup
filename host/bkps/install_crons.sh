#!/bin/sh
# script for install cron jobs. The cron jobs a picked up from $HOME_DIR/cron
#

HOME_DIR=$1

SETUP_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

CRONS_HOME="$SETUP_DIR/crons"
timestamp=`date +%Y-%m-%d_%H-%M-%S`
LOG_DIR=$HOME_DIR/shared/logs/db/cron

echo "INSTALLING CRON JOBS FROM $CRONS_HOME"

if [ -d "$LOG_DIR" ]; then
       echo "THE LOG DIR EXISTS" | tee -a $LOG_DIR/cron_install.log
else
       mkdir -p $LOG_DIR
       echo "THE LOG DIR WAS CREATED" | tee -a $LOG_DIR/cron_install.log
fi


CURR_DIR=$(pwd)

cd $CRONS_HOME

cat /var/spool/cron/crontabs/eip > CRONTAB

for FILE in *.sh; do
	cat ./$FILE >> CRONTAB
done

crontab CRONTAB -u eip

rm CRONTAB

echo "ALL CRONS WERE INSTALLED" | tee -a $LOG_DIR/cron_install.log

cd $CURR_DIR
