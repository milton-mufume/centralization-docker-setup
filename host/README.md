# Installation guide of cron jobs for database backups 

## Introduction

This installation guide is for those intending to install an automated database backup mechanism in an environment running openmrs and dbsync databases within docker containers.

## Steps to the installation

Here we have the procedure to install the jobs to automate the dbsync and openmrs databases backup:

1. Checkout the centralization-docker-setup branch EC-295 from the github;
2. Edit the file **CENTRALIZATION_HOME_DIRECTORY/conf/os/automated_bkp_env.sh** and set the values for the variables;
3. After editing the file execute the following commands:
    
    **a.** cp CENTRALIZATION_HOME_DIRECTORY/conf/os/automated_bkp_env.sh /etc/profile.d/;
    
    **b.** source /etc/profile.d/automated_bkp_env.sh;
4. Edit the time (minutes, hours, dates, etc) inside the cron's scripts within directory **CENTRALIZATION_HOME_DIRECTORY/host/bkps/crons** **¹**;
5. Run the script **CENTRALIZATION_HOME_DIRECTORY/host/bkps/bkp_installation_setup.sh** to create the directories and install the cron jobs into the host:
   
    **a.** ./bkp_installation_setup.sh (inside the **bkps** directory);

**¹**The pattern to define the times that we want the cron jobs do be executed is ***/VALUE** where the VALUE is the time shceduled to run the backups.

E.G. ***/10 * * * * other_arguments_or_path_to_the_script.sh**
