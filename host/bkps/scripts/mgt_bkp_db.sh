#!/bin/bash
#specific script for backup the mgt/dbsync database
#
#!/bin/bash
# specific script for backup the openmrs database
#
DB_CONTAINER=$MGT_DB_CONTAINER
DB_USER=$MGT_DB_USER
DB_PASSWORD=$MGT_DB_PASSWORD
DB_NAME=$MGT_DB_NAME
BKP_HOME_DIR_MGT=$EIP_HOME_DIR

echo "STARTING THE EXECUTION OF BKP_DB.SH SCRIPT"
$EIP_HOME_DIR/scripts/db-backup/bkp_db.sh $DB_CONTAINER $DB_USER $DB_PASSWORD $DB_NAME $BKP_HOME_DIR_MGT
