
#!/bin/sh
# This scrip is intended to check for updates for eip application and apply them when avaliable
#
#ENV
HOME_DIR=$home_dir
SHARED_DIR="$home_dir/shared"
SETUP_MAIN_PROJECT_DIR="/home/centralization-docker-setup"
EIP_SETUP_BASE_DIR="$SETUP_MAIN_PROJECT_DIR/dbsync-central"
EIP_SETUP_STUFF_DIR="$EIP_SETUP_BASE_DIR/release_stuff"
SCRIPTS_DIR="$HOME_DIR/scripts"
SETUP_SCRIPTS_DIR="$EIP_SETUP_STUFF_DIR/scripts"
INSTALL_FINISHED_REPORT_FILE="$HOME_DIR/install_finished_report_file"
DBSYNC_DATA_DIR=$SHARED_DIR/data
DOWNLOADED_EIP_JAR_FILE=$DBSYNC_DATA_DIR/openmrs-eip-app.jar
DOWNLOADED_C_FEATURES_JAR_FILE=$DBSYNC_DATA_DIR/centralization-features-manager.jar


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

if test ! -f "$DOWNLOADED_EIP_JAR_FILE"; then
	echo "Downloading $OPENMRS_EIP_APP_RELEASE_URL to $HOME_DIR/openmrs-eip-app.jar"
	wget -O "$HOME_DIR/openmrs-eip-app.jar" $OPENMRS_EIP_APP_RELEASE_URL

	mkdir -p $DBSYNC_DATA_DIR

	cp $HOME_DIR/openmrs-eip-app.jar $DOWNLOADED_EIP_JAR_FILE
else
	cp $DOWNLOADED_EIP_JAR_FILE $HOME_DIR/
fi

if test ! -f "$DOWNLOADED_EIP_JAR_FILE"; then
	echo "PERFORMING INSTALLATION OF NOTIFICATIONS MANAGER"

	echo "Downloading $CENTRALIZATION_FEATURES_MANAGER_RELEASE_URL to $HOME_DIR/centralization-features-manager-1.0.jar"
	wget -O "$HOME_DIR/centralization-features-manager.jar" $CENTRALIZATION_FEATURES_MANAGER_RELEASE_URL

	mkdir -p $DBSYNC_DATA_DIR

	cp $HOME_DIR/centralization-features-manager.jar $DOWNLOADED_C_FEATURES_JAR_FILE

else
	cp $DOWNLOADED_C_FEATURES_JAR_FILE $HOME_DIR/
fi


echo "ALL FILES WERE COPIED"

$SCRIPTS_DIR/apk_install.sh
$SCRIPTS_DIR/install_crons.sh
#$SCRIPTS_DIR/generate_certificate.sh "$spring_artemis_host:$spring_artemis_port" "$HOME_DIR/artemis.cert"
#$SCRIPTS_DIR/install_certificate_to_jdk_carcets.sh "$HOME_DIR/artemis.cert"


timestamp=`date +%Y-%m-%d_%H-%M-%S`
echo "Installation finished at $timestamp" >> $INSTALL_FINISHED_REPORT_FILE
