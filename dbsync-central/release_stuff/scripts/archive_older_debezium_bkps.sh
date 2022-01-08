#!/bin/sh
# script for arquive the older backps of debezium files
#

# Set environment.
HOME_DIR=/home/eip
BKPS_HOME=$HOME_DIR/shared/bkps
BKPS_ARCHIVED_HOME=$BKPS_HOME/archived
timestamp=`date +%Y-%m-%d_%H-%M-%S`
LOG_DIR=$HOME_DIR/shared/logs/debezium_bkps

if [ -d "$LOG_DIR" ]; then
       echo "THE LOG DIR EXISTS" | tee -a $LOG_DIR/archive.log
else
       mkdir -p $LOG_DIR
       echo "THE LOG DIR WAS CREATED" | tee -a $LOG_DIR/archive.log
fi

if [ ! -d "$BKPS_ARCHIVED_HOME" ]; then
   echo "$timestamp ARCHIVE DIRECTORY DOESN'T EXISTS" | tee -a $LOG_DIR/archive.log
   echo "$timestamp ARCHIVE DIRECTORY IS BEING CREATED" | tee -a $LOG_DIR/archive.log
   mkdir $BKPS_ARCHIVED_HOME
   echo "$timestamp ARCHIVE DIRECTORY WAS CREATED" | tee -a $LOG_DIR/archive.log
fi

BKPS_TO_BE_ARCHIVED_HOME="$BKPS_HOME/archive_$(ls $BKPS_ARCHIVED_HOME | wc -l)"

if [ ! -d "$BKPS_TO_BE_ARCHIVED_HOME" ]; then
	echo "$timestamp CREATING TEMPORARY DIR FOR ARCHIVING CURRENT FILES($BKPS_TO_BE_ARCHIVED_HOME)" | tee -a $LOG_DIR/archive.log
	mkdir -p $BKPS_TO_BE_ARCHIVED_HOME
fi

#find $BKPS_HOME -type f -name '*.txt*' -mmin +3 -exec mv {} $BKPS_TO_BE_ARCHIVED_HOME \;
find $BKPS_HOME -type f -name '*.txt*' -mtime +15 -exec mv {} $BKPS_TO_BE_ARCHIVED_HOME \;

QTY_RECORDS=$(ls $BKPS_TO_BE_ARCHIVED_HOME/* | wc -l)

echo "$timestamp $QTY_RECORDS RECORDS WILL BE ARCHIVED!" | tee -a $LOG_DIR/archive.log

if [ "$QTY_RECORDS" -gt 99 ]; then
	echo "$timestamp COMPRESSING $BKPS_TO_BE_ARCHIVED_HOME BEFORE ARCHIVE..." | tee -a $LOG_DIR/archive.log
	tar -zcvf $BKPS_TO_BE_ARCHIVED_HOME".tar.gz" $BKPS_TO_BE_ARCHIVED_HOME	
	mv $BKPS_TO_BE_ARCHIVED_HOME".tar.gz" $BKPS_ARCHIVED_HOME
	echo "$timestamp COMPRESSING OF $BKPS_TO_BE_ARCHIVED_HOME IS DONE" | tee -a $LOG_DIR/archive.log
else
	echo "$timestamp THE NUMBER OF FILES TO BE ARCHIVE IS LESS THAN 100. ARCHIVE WILL BE SKIPPED" | tee -a $LOG_DIR/archive.log
	mv $BKPS_TO_BE_ARCHIVED_HOME/* $BKPS_HOME/

fi

rm -fr $BKPS_TO_BE_ARCHIVED_HOME


echo "$timestamp ARCHIVING OF OLDER FILES IS DONE!" | tee -a $LOG_DIR/archive.log


