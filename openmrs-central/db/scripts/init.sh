#!/bin/bash

apt-get update
apt-get install -y cron
apt-get install -y vim
apt-get install -y procps

env > /home/env.sh

/home/scripts/install_crons.sh
service cron start

exec /usr/sbin/mysqld --user=root --console
