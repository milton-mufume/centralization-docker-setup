#!/bin/sh
# script for install cron jobs. The cron jobs a picked up from $HOME_DIR/cron
#

# Set environment.
HOME_DIR=/home
CRONS_HOME=$HOME_DIR/db/crons
timestamp=`date +%Y-%m-%d_%H-%M-%S`
LOG_DIR=$HOME_DIR/shared/logs/db/cron

if [ -d "$LOG_DIR" ]; then
       echo "THE LOG DIR EXISTS" | tee -a $LOG_DIR/cron_install.log
else
       mkdir -p $LOG_DIR
       echo "THE LOG DIR WAS CREATED" | tee -a $LOG_DIR/cron_install.log
fi

cd $CRONS_HOME

cat default > CRONTAB 

for FILE in *.sh; do 
	cat ./$FILE >> CRONTAB
done

crontab CRONTAB

rm CRONTAB

echo "AL CRONS WERE INSTALLED" | tee -a $LOG_DIR/cron_install.log

