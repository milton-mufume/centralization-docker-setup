#!/bin/sh
# script for install cron jobs. The cron jobs a picked up from $HOME_DIR/cron

SETUP_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CRONS_HOME="$SETUP_DIR/crons"
CONFIG_FILE="$SETUP_DIR/conf.sh"
SCRIPT_LOCATION="$SETUP_DIR/scripts"

. $CONFIG_FILE

LOG_DIR=$EIP_HOME_DIR/shared/logs/bkps/db/cron

timestamp=`date +%Y-%m-%d_%H-%M-%S`


if [ -d "$LOG_DIR" ]; then
       echo "THE LOG DIR EXISTS" | tee -a $LOG_DIR/cron_install.log
else
       mkdir -p $LOG_DIR
       echo "THE LOG DIR WAS CREATED" | tee -a $LOG_DIR/cron_install.log
fi

echo "SETUP DIR: $SETUP_DIR" | tee -a $LOG_DIR/cron_install.log
echo "EIP_HOME_DIR $EIP_HOME_DIR"
echo "INSTALLING CRON JOBS FROM $CRONS_HOME" | tee -a $LOG_DIR/cron_install.log

CURR_DIR=$(pwd)

cd $CRONS_HOME

cat /var/spool/cron/crontabs/eip > CRONTAB

for FILE in *.sh; do
	tmpfile="${FILE}.tmp"

	cp $FILE $tmpfile
	
	sed -i "s|SCRIPT_LOCATION|$SCRIPT_LOCATION|g" $tmpfile
	sed -i "s|CONFIG_FILE|$CONFIG_FILE|g" $tmpfile

	cat ./$tmpfile >> CRONTAB

	rm $tmpfile
done

crontab CRONTAB -u eip

rm CRONTAB

echo "ALL CRONS WERE INSTALLED" | tee -a $LOG_DIR/cron_install.log






cd $CURR_DIR
