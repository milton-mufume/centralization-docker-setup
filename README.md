# Centralization Project
## Introduction

This document intends the important notes to be observed by the BD SYNC implementer. Here  are presented the steps that are supposed to be followed to carry out the installation.
The implementation of centralization is fundamentally divided into two stages: (1) configuration and initialization of central server services (2) configuration of remote sites and their inclusion in the central site. The inclusion of remote sites will be done one by one.
In this document we'll cover the setup of the central servers (stage (1)).

# Central Server Setup

### Creation of user eip on the Server

All configurations mentioned in this document must be carried out using the **eip** user. To do so, you must first create this user using the instructions below:


>**sudo useradd -m -s /bin/bash -G sudo eip**

>**sudo passwd eip**
_[insert the desired password]_


Add user eip to admin groups:


>**sudo usermod -aG sudo eip**


### Installation and Configuration of the Central Server
All services needed to get the core server up and running will be installed using [this docker project](https://github.com/FriendsInGlobalHealth/centralization-docker-setup/tree/production).
Follow the steps below to configure the central server:
<br><br>**1.** Login to the server using user **eip**
     
 
 <br>**2.** Position yourself in the user's root directory
>**cd /home/eip**
 
 
<br>**3.** Create the required directory structure.

>**mkdir -p prg/docker**

>**mkdir -p shared/**

>**mkdir -p shared/bkps**


<br>**4.** Install docker following the commands below


>**sudo apt-get update**

>**sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release**


>**curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg**

>**echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null**


>**sudo apt-get update**

>**sudo apt-get install docker-ce docker-ce-cli containerd.io**


<br>**5.** Install docker-compose

>**sudo apt-get install docker-compose**
    

<br>**6.** Create the docker group and add the eip user in it

>**sudo adduser $USER docker**

>**sudo systemctl restart docker.service**


<br>**7.** Clone the docker project for services configuration

>**cd /home/eip/prg/docker**

>**git clone https://github.com/FriendsInGlobalHealth/centralization-docker-setup.git**
<br>**NOTE:** After cloning the above project we need to swicth to the branch **"production"** in order to continue with this process



<br>**8.** Copy the configuration files to the directory shared

>**cp -R /home/eip/prg/docker/centralization-docker-setup/conf /home/eip/shared**



<br>**9.** Copy the **/home/eip/shared/conf/os/centralization.sh** file to the **/etc/profile.d/ directory**. This file contains environment variables used in docker services. **Example:** access ports to services from the host. Make the necessary changes if you want to modify any service access port.

>**sudo cp /home/eip/shared/conf/os/centralization.sh  /etc/profile.d/**

Then run:

>**source /etc/profile.d/centralization.sh**


<br>**10.** Make the necessary changes to the files contained in the newly copied **'conf'** directory to **/home/eip/shared**.<br>

<br>**11.** Create the volumes below:
>**docker volume create openmrsDbData**<br>
>**docker volume create opencrDbData**<br>
>**docker volume create esData**<br>
>**docker volume create dbSyncCentralDbData**<br>
>**docker volume create artemisData**

<br>**10.** Configure the ssl key for artemis hiting bellow commands<br>
Change directory to /home/eip/shared/conf

 <br>**12.** After making the necessary settings, run the command below to start all services.
>**docker-compose -f /home/eip/prg/docker/centralization-docker-setup/docker-compose.prod.yml up -d**

This command creates 9 containers described below:<br>
    • dbsync-central: this container provides eip services for the receiver.<br>
    • opencr: this container provides the opencr service<br>
    • openmrs-central: this container provides the openmrs application service<br>
    • artemis: this container provides the ArtemisMQ service<br>
    • mysql-openmrs-central: this container provides the openmrs DBMS<br>
    • mysql-dbsync-central: this container provides the dbsync DBMS<br>
    • es: this container provides the elastic search service for opencr<br>
    • hapi-fhir: this container provides hapi-fhir services to opencr<br>
    • mysql-opencr: this container makes the DBMS available to opencr<br>
    
 Alternatively, containers can be created individually using the command below:<br>
 >**docker-compose -f /home/eip/prg/docker/centralization-docker-setup/docker-compose.prod.yml up -d --build CONTAINER-NAME**<br>
 
 Where **CONTAINER-NAME** is the identifier of the container to be created.<br>
 
 The alternative of installing individual containers is indicated in those situations in which it is not intended to install all containers on the central server.<br>
 
 ### Replacement of the first database on the Central site
 
 To restore the backup of the 'Sede' database on the central site, you must first ensure that the mysql-central container is on top and then: 

1. Upload the database reset file to /home/eip/shared/bkps. Note that this is the database dump chosen to initialize the switch database.

2. Import using the command below:

>**docker exec -i mysql-openmrs-central /usr/bin/mysql -e "CREATE DATABASE IF NOT EXISTS DB_NAME CHARACTER SET utf8;" -u root --password=DB_PASSWORD**

>**cat /home/eip/shared/bkps/DB_SCRIPT | docker exec -i mysql-openmrs-central /usr/bin/mysql -u root --password=DB_PASSWORD DB_NAME**

Where:<br> 
**DB_SCRIPT:** is the file containing the database backup<br>
**DB_PASSWORD:** is mysql root password<br>
**DB_NAME:** is the name of the database<br>

3. If necessary, create the database access users (container mysql-central) that were defined in the configuration files in point 10 of the previous section.
E.g:
>**CREATE USER 'USER'@'%' IDENTIFIED BY 'DB_PASSWORD';**<br>
>**GRANT ALL PRIVILEGES ON DB_NAME.\* TO 'USER'@'%';**<br>
>**FLUSH PRIVILEGES;**

   a. Test access to the MySQL console using the users created above, and if you get an error, check if there are registered anonymous users:
   >**docker exec -i mysql-central /usr/bin/mysql -e "SELECT COUNT(*) ANONYMOUS_USERS FROM mysql.user WHERE User='';" -u root -p**
   
   b. If the above query returned a value other than 0 (zero), proceed with the elimination of anonymous users:
   >**docker exec -i mysql-central /usr/bin/mysql -e "DELETE FROM mysql.user WHERE User=''; FLUSH PRIVILEGES;" -u root -p**
   
   c. Retest access with previously created users.

4. Restart all services using the command<br>
>**docker-compose -f /home/eip/prg/docker/centralization-docker-setup/docker-compose.prod.yml restart**


### Volumes defined on the Server

The table below lists all docker volumes where important container information is persisted. Ensure these volumes are instantly backed up.
 
 | **Volume**   |**Description**| **what is saved**  |
| ------------- |:-------------:| -----:|
| artemisData      |ArtemisMQ data| /var/lib/artemis|
|esData    | opencr elastic search data      |   /usr/share/elasticsearch/data |
| openmrsDbData| openmrs database and receiver mgt database    |    /var/lib/mysql |
|opencrDbData|Opencr database|/var/lib/mysql|
|dbsyncDbData|Dbsync database|/var/lib/mysql|


