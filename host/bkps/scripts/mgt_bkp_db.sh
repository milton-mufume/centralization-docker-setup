#!/bin/bash
#specific script for backup the mgt/dbsync database
#
#!/bin/bash
# specific script for backup the openmrs database
#
DATABASE_TYPE=$MGT_DB_NAME
DB_CONTAINER=$MGT_DB_CONTAINER
DB_USER=$MGT_DB_USER
DB_PASSWORD=$MGT_DB_PASSWORD
DB_NAME=$MGT_DB_NAME
HOME_DIR_CONTAINER=$MGT_HOME_DIR_CONTAINER

echo "STARTING THE EXECUTION OF BKP_DB.SH SCRIPT" | tee -a $LOG_DIR/bkps.log
source $BKP_HOME_DIR/scripts/bkp_db.sh $DATABASE_TYPE $DB_CONTAINER $DB_USER $DB_PASSWORD $DB_NAME $HOME_DIR_CONTAINER
