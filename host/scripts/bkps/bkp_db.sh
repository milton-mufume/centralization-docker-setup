#!/bin/bash
# generic script for backup the dbsync mgt and openmrs databases
#

source /home/db/env.sh

# Set environment.
HOME_DIR=/home

#The database type can be "openmrs" "mgt"
DATABASE_TYPE=$1

BKPS_HOME=$HOME_DIR/shared/bkps/db/$DATABASE_TYPE
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
DB_BKP_FILE="${DATABASE_TYPE}_db_$timestamp.sql.gz"
LOG_DIR=$HOME_DIR/shared/logs/db/bkp/$DATABASE_TYPE

echo "USER: $(whoami)" | tee -a $LOG_DIR/bkps.log

printenv >>$LOG_DIR/bkps.log

echo "DB TYPE: $DATABASE_TYPE" | tee -a $LOG_DIR/bkps.log

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

DATABASE=$DATABASE_TYPE

echo "THE DATABASE IS" $DATABASE | tee -a $LOG_DIR/bkps.log
echo "THE DATABASE IS $DATABASE: $DATABASE ALIAS: $DATABASE" | tee -a $LOG_DIR/bkps.log

echo "STARTING BACKUP OF $DATABASE database" | tee -a $LOG_DIR/bkps.log

