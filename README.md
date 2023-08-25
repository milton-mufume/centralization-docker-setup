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

<br>**12.** Configure the ssl key for artemis<br>
Change directory to /home/eip/shared/conf/artemis/certificates/server

In bellow command change HOST_NAME to the name of the host (ex: epts-niassa.fgh.org.mz) and then run the 3 commands bellow one-by-one

>**openssl req -nodes -new -x509 -days 3560 -keyout broker_key.pem -out broker_crt.pem -subj "/CN=HOST_NAME"**<br>
>**openssl pkcs12 -export -in broker_crt.pem -inkey broker_key.pem -out broker.p12**<br>
>**keytool -importkeystore -srckeystore broker.p12 -srcstoretype pkcs12 -destkeystore broker.ks**<br>

 <br>**13.** After making the necessary settings, start the services following the sequence.

>Start mysql-openmrs-central container: "docker-compose -f /home/eip/prg/docker/centralization-docker-setup/docker-compose.prod.minimal.yml up -d --build mysql-openmrs-central"
Restore the central database<br>

3. If necessary, create the database access users (container mysql-central) that were defined in the configuration files in point 10 of the previous section.
E.g:
>**CREATE USER 'USER'@'%' IDENTIFIED BY 'DB_PASSWORD';**<br>
>**GRANT ALL PRIVILEGES ON DB_NAME.\* TO 'USER'@'%';**<br>
>**FLUSH PRIVILEGES;**

Make the necessary changes on file: /home/eip/shared/conf/os/automated_bkp_env.sh.sh
>Run **source /home/eip/shared/conf/os/automated_bkp_env.sh.sh**
> Hit "docker exec -i mysql-openmrs-central /usr/bin/mysql -e "CREATE DATABASE  IF NOT EXISTS $OPENMRS_DB_NAME /*!40100 DEFAULT CHARACTER SET utf8 */;" -u $OPENMRS_DB_USER --password=$OPENMRS_DB_PASSWORD
> Hit "cat /home/eip/shared/conf/openmrs/central/db/openmrs. | docker exec -i $DB_CONTAINER /usr/bin/mysql -u root --password=root $DB_NAME"

>Start "artemis-central container: "docker-compose -f /home/eip/prg/docker/centralization-docker-setup/docker-compose.prod.minimal.yml up -d --build artemis-central"
>Start "openmrs-central container: "docker-compose -f /home/eip/prg/docker/centralization-docker-setup/docker-compose.prod.minimal.yml up -d --build openmrs-central"
>Start "mysql-dbsync-central container: "docker-compose -f /home/eip/prg/docker/centralization-docker-setup/docker-compose.prod.minimal.yml up -d --build mysql-dbsync-central"
>Start "dbsync-central container: "docker-compose -f /home/eip/prg/docker/centralization-docker-setup/docker-compose.prod.minimal.yml up -d --build dbsync-central"
 
