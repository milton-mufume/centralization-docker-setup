#!/bin/sh
# script for backup the dbsync mgt database
#

# Set environment.
HOME_DIR=/home
BKPS_HOME=$HOME_DIR/shared/bkps/db/mgt
timestamp=`date +%Y-%m-%d_%H-%M-%S`
MGT_FILE_BKP="receiver_mgt_db_$timestamp.sql.gz"
LOG_DIR=$HOME_DIR/shared/logs/mgt_bkps

if [ -d "$LOG_DIR" ]; then
       echo "THE LOG DIR EXISTS" | tee -a $LOG_DIR/bkps.log
else
       mkdir -p $LOG_DIR
       echo "THE LOG DIR WAS CREATED" | tee -a $LOG_DIR/bkps.log
fi


if [ -d "$BKPS_HOME" ]; then
   echo "BKPS DIRECTORY ALREDY EXISTS" | tee -a $LOG_DIR/bkps.log
else
   echo "BKPS DIRECTORY DOESN'T EXISTS" | tee -a $LOG_DIR/bkps.log
   echo "BKPS DIRECTORY IS BEING CREATED" | tee -a $LOG_DIR/bkps.log
   mkdir -p $BKPS_HOME
   echo "BKPS DIRECTORY WAS CREATED" | tee -a $LOG_DIR/bkps.log

fi

cd $BKPS_HOME

echo "STARTING BACKUP" | tee  -a $LOG_DIR/bkps.log
/usr/bin/mysqldump -u root --password=$MYSQL_ROOT_PASSWORD openmrs_eip_receiver_mgt | gzip > $BKPS_HOME/$MGT_FILE_BKP 
echo "BACKUP FINISHED" | tee  -a $LOG_DIR/bkps.log

