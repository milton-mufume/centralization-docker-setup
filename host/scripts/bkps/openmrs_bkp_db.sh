#!/bin/bash
# specific script for backup the openmrs database
#
source /home/db/scripts/bkp_db.sh

#
docker exec $OPENMRS_DB_CONTAINER bash -c "/usr/bin/mysqldump -u $OPENMRS_DB_USER --password=$OPENMRS_DB_PASSWORD $OPENMRS_DB_NAME 2> /dev/null | gzip > /$OPENMRS_HOME_DIR_CONTAINER/${OPENMRS_DB_NAME}_db_$timestamp.sql.gz"
#
docker cp $OPENMRS_DB_CONTAINER:/$OPENMRS_HOME_DIR_CONTAINER/"${OPENMRS_DB_NAME}"_db_$timestamp.sql.gz $BKPS_HOME
#
docker exec $OPENMRS_DB_CONTAINER bash -c "rm /$OPENMRS_HOME_DIR_CONTAINER/${OPENMRS_DB_NAME}_db_$timestamp.sql.gz"
#
echo "BACKUP FINISHED" | tee  -a $LOG_DIR/bkps.log