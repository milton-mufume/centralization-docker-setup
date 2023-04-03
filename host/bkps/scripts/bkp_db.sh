#!/bin/bash
# generic script for backup the dbsync mgt and openmrs databases
#
DB_CONTAINER=$1
DB_USER=$2
DB_PASSWORD=$3
DB_NAME=$4
HOME_DIR=$5

#
BKPS_HOME=$HOME_DIR/shared/bkps/db/$DB_NAME
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
DB_BKP_FILE="${DB_NAME}_db_$timestamp.sql.gz"
LOG_DIR=$HOME_DIR/shared/logs/db/bkp/$DB_NAME



echo "DB TYPE: $DB_NAME" | tee -a $LOG_DIR/bkps.log

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

echo "THE DATABASE IS" $DB_NAME | tee -a $LOG_DIR/bkps.log
echo "THE DATABASE IS $DB_NAME: $DB_NAME ALIAS: $DB_NAME" | tee -a $LOG_DIR/bkps.log

#
docker exec $DB_CONTAINER bash -c "/usr/bin/mysqldump -u $DB_USER --password=$DB_PASSWORD $DB_NAME 2> /dev/null | gzip" > $BKPS_HOME/${DB_BKP_FILE}
#
echo "BACKUP FINISHED" | tee -a $LOG_DIR/bkps.log

