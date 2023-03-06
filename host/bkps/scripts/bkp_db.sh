#!/bin/bash
# generic script for backup the dbsync mgt and openmrs databases
#
DATABASE_TYPE=$1
DB_CONTAINER=$2
DB_USER=$3
DB_PASSWORD=$4
DB_NAME=$5
HOME_DIR_CONTAINER=$6

#
HOME_DIR=$BKP_HOME_DIR
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

echo "THE DATABASE IS" $DATABASE_TYPE | tee -a $LOG_DIR/bkps.log
echo "THE DATABASE IS $DATABASE_TYPE: $DATABASE_TYPE ALIAS: $DATABASE_TYPE" | tee -a $LOG_DIR/bkps.log

echo "STARTING BACKUP OF $DATABASE_TYPE database" | tee -a $LOG_DIR/bkps.log

#
docker exec $DB_CONTAINER bash -c "/usr/bin/mysqldump -u $DB_USER --password=$DB_PASSWORD $DB_NAME 2> /dev/null | gzip > $HOME_DIR_CONTAINER/${DB_BKP_FILE}"
#
docker cp $DB_CONTAINER:$HOME_DIR_CONTAINER/$DB_BKP_FILE $BKPS_HOME
#
docker exec $DB_CONTAINER bash -c "rm $HOME_DIR_CONTAINER/$DB_BKP_FILE"
#
echo "BACKUP FINISHED" | tee -a $LOG_DIR/bkps.log

