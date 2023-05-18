#!/bin/sh
# This script contains shared functions 
#

getScriptLocation(){
	SCRIPT_LOCATION=$( cd -- "$( dirname -- "${BASH_SOURCE[1]}" )" &> /dev/null && pwd )
	echo $SCRIPT_LOCATION
}

getCurrDateTime(){
	timestamp=`date +%Y-%m-%d_%H-%M-%S`

	echo $timestamp
}

logToScreenAndFile(){
	log_msg=$1
	log_file=$2
	LOG_DIR=$(dirname "$log_file")

	if [ -d "$LOG_DIR" ]; then
       		echo "THE LOG DIR EXISTS" | tee -a $log_file 
	else
       		mkdir -p $LOG_DIR
       		echo "THE LOG DIR WAS CREATED" | tee -a $log_file 
	fi

	echo $log_msg | tee -a $log_file 
}

checkIfProcessIsRunning(){
	processName=$1

	#quantidade minima de linhas que indica que o processo esta a correr
	defaultNumberOfLinesOnPsCommand=$2

	if [ -z "$defaultNumberOfLinesOnPsCommand" ]; then
		defaultNumberOfLinesOnPsCommand=1;
	fi

	currTime=$(getCurrDateTime)

	RUNNING_PROCESS="./running_process_check_${processName}_${currTime}"

	ps -aef | grep $processName > $RUNNING_PROCESS

	wcResult=$(wc $RUNNING_PROCESS)
	linesCount=$(echo $wcResult | cut -d' ' -f1)

	rm $RUNNING_PROCESS

	if [ $linesCount -gt $defaultNumberOfLinesOnPsCommand ]; then
		return 1;
	else
		return 0;
	fi

}

