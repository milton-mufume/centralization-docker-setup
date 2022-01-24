#!/bin/bash

apt-get update
apt-get install -y cron
apt-get install -y vim
apt-get install -y procps

env > /home/env.sh

/home/scripts/install_crons.sh

echo "Starting cron"

service cron start

#echo "Starting mysql"

#/home/scripts/run.sh
#crond -f -l 8
#echo "Crond finished"

