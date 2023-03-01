#!/bin/bash
#specific script for backup the mgt/dbsync database
#
#!/bin/bash
# specific script for backup the openmrs database
#
export DATABASE_TYPE="mgt"
export DB_CONTAINER=$MGT_DB_CONTAINER
export DB_USER=$MGT_DB_USER
export DB_PASSWORD=$MGT_DB_PASSWORD
export DB_NAME=$MGT_DB_NAME
export HOME_DIR_CONTAINER=/home

echo "STARTING THE EXECUTION OF BKP_DB.SH SCRIPT" | tee -a $LOG_DIR/bkps.log
source $HOME_DIR/db/scripts/bkp_db.sh
