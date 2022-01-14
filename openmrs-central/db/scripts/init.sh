#!/bin/bash

apt-get update
apt-get install -y cron
apt-get install -y vim

/home/scripts/install_crons.sh

exec /usr/sbin/mysqld --user=root --console
