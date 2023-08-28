#!/bin/bash
#specific script for backup the mgt/dbsync database
#
#!/bin/bash
# specific script for backup the openmrs database
#

CONFIG_FILE=$1

. $CONFIG_FILE

SCRIPT_LOCATION=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DB_CONTAINER=$MGT_DB_CONTAINER
DB_USER=$MGT_DB_USER
DB_PASSWORD=$MGT_DB_PASSWORD
DB_NAME=$MGT_DB_NAME
BKP_HOME_DIR_MGT=$EIP_HOME_DIR

$SCRIPT_LOCATION/bkp_db.sh $DB_CONTAINER $DB_USER $DB_PASSWORD $DB_NAME $BKP_HOME_DIR_MGT
