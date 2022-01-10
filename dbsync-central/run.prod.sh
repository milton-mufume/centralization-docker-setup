#!/bin/sh
HOME_DIR="/home/eip"
SCRIPTS_DIR="$HOME_DIR/scripts"
INSTALL_FINISHED_REPORT_FILE="$HOME_DIR/install_finished_report_file"

if [ -f "$INSTALL_FINISHED_REPORT_FILE" ]; then
        echo "INSTALLATION ALREADY FINISHED"
else
  ./init.sh
fi

$SCRIPTS_DIR/eip_startup.sh

crond -f -l 8
