#!/bin/sh
# script for cleanup the older mgt bkp files
#

#The database type can be "openmrs" "mgt"
DATABASE_NAME=$1
HOME_DIR=$2

BKPS_DIR=$HOME_DIR/shared/bkps/db/$DATABASE_NAME
BKPS_TO_BE_PRESERVED_DIR=$HOME_DIR/tmp/$DATABASE_NAME/to_be_preserved
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
LOG_DIR=$HOME_DIR/shared/logs/db/bkp/$DATABASE_NAME

if [ -d "$LOG_DIR" ]; then
  echo "THE LOG DIR EXISTS" | tee -a $LOG_DIR/arquive.log
else
  mkdir -p $LOG_DIR
  echo "THE LOG DIR WAS CREATED" | tee -a $LOG_DIR/arquive.log
fi

if [ ! -d "$BKPS_TO_BE_PRESERVED_DIR" ]; then
  echo "$timestamp THE TEMPORARY DIRECTORY FOR FILES TO BE PRESERVED ($BKPS_TO_BE_PRESERVED_DIR) DOESN'T EXISTS" | tee -a $LOG_DIR/bkps_cleanup.log
  mkdir -p $BKPS_TO_BE_PRESERVED_DIR
  echo "$timestamp THE TEMPORARY DIRECTORY FOR FILES TO BE PRESERVED($BKPS_TO_BE_PRESERVED_DIR) WAS CREATED" | tee -a $LOG_DIR/bkps_cleanup.log
fi

DAY=2
MAX_DAY=365
MIN_FILES_TO_BE_PRESERVED=2
QTY_RECORDS_TO_BE_PRESERVED=0

while [ "$QTY_RECORDS_TO_BE_PRESERVED" -le "$MIN_FILES_TO_BE_PRESERVED" ] && [ "$DAY" -le "$MAX_DAY" ]; do
  #MOVE THE NEWER FILES TO TEMPORARY FOLDER
  echo "TRYING TO MOVE LESS THAT $DAY DAYS FILES TO TEMPORARY DIRECTORY FOR FILES TO BE PRESERVED" | tee -a $LOG_DIR/bkps_cleanup.log

  #find $BKPS_DIR -type f -name '*.gz' -mmin -$DAY -size +1M -exec mv {} $BKPS_TO_BE_PRESERVED_DIR \;
  find $BKPS_DIR -type f -name '*.gz' -mtime -$DAY -size +1M -exec mv {} $BKPS_TO_BE_PRESERVED_DIR \;

  QTY_RECORDS_TO_BE_PRESERVED=$(ls $BKPS_TO_BE_PRESERVED_DIR/ | wc -l)

  DAY=$((DAY + 1))
done

echo "$timestamp $QTY_RECORDS_TO_BE_PRESERVED RECORDS WILL BE PRESERVED!" | tee -a $LOG_DIR/bkps_cleanup.log

if [ "$QTY_RECORDS_TO_BE_PRESERVED" -ge "$MIN_FILES_TO_BE_PRESERVED" ]; then
  echo "$timestamp REMOVING OLDER BKPS..." | tee -a $LOG_DIR/bkps_cleanup.log
  rm -fr $BKPS_DIR/*.gz
  echo "$timestamp OLDER BKPS REMOVED" | tee -a $LOG_DIR/bkps_cleanup.log
else
  echo "$timestamp THE NUMBER OF FILES TO BE PRESERVED IS LESS THAT 2. THE REMOTION WILL BE SKIPPED" | tee -a $LOG_DIR/bkps_cleanup.log
fi

mv $BKPS_TO_BE_PRESERVED_DIR/* $BKPS_DIR/
rm -fr $BKPS_TO_BE_PRESERVED_DIR

echo "$timestamp THE CLEANUP OF OLDER FILES IS DONE!" | tee -a $LOG_DIR/arquive.log
