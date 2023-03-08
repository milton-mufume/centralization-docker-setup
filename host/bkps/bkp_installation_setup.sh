#!/bin/bash

echo "CREATING THE scripts/db-backup DIRECTORY AT: "$EIP_HOME_DIR



mkdir -p $EIP_HOME_DIR/scripts
mkdir -p $EIP_HOME_DIR/scripts/db-backup

cp scripts/* -r $EIP_HOME_DIR/scripts/db-backup

/bin/bash install_crons.sh $EIP_HOME_DIR

echo "SCRIPTS CREATED AT HOME DIRECTORY: "$EIP_HOME_DIR/scripts/db-backup