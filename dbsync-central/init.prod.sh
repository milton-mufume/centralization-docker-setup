
#!/bin/sh
# This scrip is intended to check for updates for eip application and apply them when avaliable
#
#ENV
HOME_DIR=$home_dir
SETUP_MAIN_PROJECT_DIR="/home/centralization-docker-setup"
EIP_SETUP_BASE_DIR="$SETUP_MAIN_PROJECT_DIR/dbsync-central"
EIP_SETUP_STUFF_DIR="$EIP_SETUP_BASE_DIR/release_stuff"
SCRIPTS_DIR="$HOME_DIR/scripts"
SETUP_SCRIPTS_DIR="$EIP_SETUP_STUFF_DIR/scripts"
INSTALL_FINISHED_REPORT_FILE="$HOME_DIR/install_finished_report_file"

timestamp=`date +%Y-%m-%d_%H-%M-%S`

echo "STARTING EIP INSTALLATION PROCESS AT $timespamp"

cd $HOME_DIR

source $SETUP_SCRIPTS_DIR/release_info.sh

REMOTE_RELEASE_NAME=$RELEASE_NAME
REMOTE_RELEASE_DATE=$RELEASE_DATE

echo "FOUND RELEASE {NAME: $REMOTE_RELEASE_NAME, DATE: $REMOTE_RELEASE_DATE} "

echo "PERFORMING INSTALLATION STEPS..."

echo "COPPING EIP APP FILES"

cp -R $EIP_SETUP_STUFF_DIR/* $HOME_DIR/

echo "COPYING DOCKER PROJECT TO EIP DIR"
cp -R $SETUP_MAIN_PROJECT_DIR $HOME_DIR

echo "ALL FILES WERE COPIED"

$SCRIPTS_DIR/apk_install.sh
$SCRIPTS_DIR/install_crons.sh

timestamp=`date +%Y-%m-%d_%H-%M-%S`
echo "Installation finished at $timestamp" >> $INSTALL_FINISHED_REPORT_FILE
