# Installation guide of cron jobs for database backups 

## Introduction

This installation guide is for those intending to install an automated database backup mechanism in an environment running openmrs and dbsync databases within docker containers.

## Steps to the installation

Here we have the procedure to install the jobs to automate the dbsync and openmrs databases backup:

1. Checkout the centralization-docker-setup branch production from the github;
2. Copy all content of the **CENTRALIZATION_HOME_DIRECTORY/host/bkps/** folder to /home/eip/shared/bkps/
3. Edit the configuration file (conf.sh) under /home/eip/shared/bkps/ providing the correct values
4. Run the install.sh script under /home/eip/shared/bkps/ as a sudo
5. You are done
