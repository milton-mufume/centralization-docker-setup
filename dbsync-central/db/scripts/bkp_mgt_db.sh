#!/bin/bash
# script for backup the dbsync mgt database
#
source /home/env.sh

# Set environment.
HOME_DIR=/home

#The database type can be "openmrs" "mgt"
DATABASE_TYPE=$1

BKPS_HOME=$HOME_DIR/shared/bkps/db/$DATABASE_TYPE
timestamp=`date +%Y-%m-%d_%H-%M-%S`
DB_BKP_FILE="${DATABASE_TYPE}_db_$timestamp.sql.gz"
LOG_DIR=$HOME_DIR/shared/logs/db/bkp/$DATABASE_TYPE

#The Container Name must be the one that we want to create a dump from it
CONTAINER_NAME=PLACE_THE_CONTAINER_NAME

MYSQL_ROOT_PASSWORD = PLACE_THE_DB_PASSWORD


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

DATABASE=$OPENMRS_DB

if [ "$DATABASE_TYPE" = "mgt" ]; then
   DATABASE=$OPENMRS_EIP_MGT_DB
   echo "THE DATABASE IS $OPENMRS_EIP_MGT_DB" | tee -a $LOG_DIR/bkps.log
   echo "THE DATABASE IS MGT: $OPENMRS_EIP_MGT_DB ALIAS: $DATABASE" | tee -a $LOG_DIR/bkps.log
else
   echo "THE DATABASE IS MGT: $OPENMRS_DB ALIAS: $DATABASE" | tee -a $LOG_DIR/bkps.log
fi

echo "STARTING BACKUP OF $DATABASE database" | tee  -a $LOG_DIR/bkps.log
docker exec $CONTAINER_NAME bash -c "/usr/bin/mysqldump -u root --password=$MYSQL_ROOT_PASSWORD $DATABASE  2> /dev/null | gzip > $HOME_DIR/mgt_db_$timestamp.sql.gz"

docker cp $CONTAINER_NAME:$HOME_DIR/mgt_db_$timestamp.sql.gz $BKPS_HOME
docker exec $CONTAINER_NAME bash -c "rm $HOME_DIR/mgt_db_$timestamp.sql.gz"

echo "BACKUP FINISHED" | tee  -a $LOG_DIR/bkps.log

