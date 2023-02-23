#!/bin/bash
#specific script for backup the mgt/dbsync database
#
source /home/mmufume/db/scripts/bkp_db.sh

#
docker exec $MGT_DB_CONTAINER bash -c "/usr/bin/mysqldump -u $MGT_DB_USER --password=$MGT_DB_PASSWORD $MGT_DB_NAME 2> /dev/null | gzip > /$MGT_HOME_DIR_CONTAINER/${MGT_DB_NAME}_db_$timestamp.sql.gz"
#
docker cp $MGT_DB_CONTAINER:/$MGT_HOME_DIR_CONTAINER/"${MGT_DB_NAME}"_db_$timestamp.sql.gz $BKPS_HOME
#
docker exec $MGT_DB_CONTAINER bash -c "rm /$MGT_HOME_DIR_CONTAINER/${MGT_DB_NAME}_db_$timestamp.sql.gz"
#
echo "BACKUP FINISHED" | tee -a $LOG_DIR/bkps.log
