#!/bin/bash
#specific script for backup the mgt/dbsync database
#
#!/bin/bash
# specific script for backup the openmrs database
#

CONFIG_FILE=$1

. $CONFIG_FILE

SCRIPT_LOCATION=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

$SCRIPT_LOCATION/delete_old_bkps.sh $OPENMRS_DB_NAME $EIP_HOME_DIR
