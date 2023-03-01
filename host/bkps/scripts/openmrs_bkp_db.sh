#!/bin/bash
# specific script for backup the openmrs database
#
export DATABASE_TYPE="openmrs"
export DB_CONTAINER=$OPENMRS_DB_CONTAINER
export DB_USER=$OPENMRS_DB_USER
export DB_PASSWORD=$OPENMRS_DB_PASSWORD
export DB_NAME=$OPENMRS_DB_NAME
export HOME_DIR_CONTAINER=/home

echo "STARTING THE EXECUTION OF BKP_DB.SH SCRIPT" | tee -a $LOG_DIR/bkps.log
source $HOME_DIR/db/scripts/bkp_db.sh
