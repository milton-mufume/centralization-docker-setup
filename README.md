# Centralization Project -  Implementation Plan
## Introduction

This document intends the important notes to be observed by the BD SYNC implementer. Here, the steps that are supposed to be followed to carry out the installation are presented.
The implementation of centralization is fundamentally divided into two stages: (1) configuration and initialization of central server services (2) configuration of remote sites and their inclusion in the central site. The inclusion of remote sites will be done one by one.
In this document we'll cover the setup of the central servers.

# Execution of synchronization and creation of sede backup
Synchronization and backup should be done following the usual procedures.

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
 1. Login to the server using user **eip**
     
 
 2. Position yourself in the user's root directory
>**cd /home/eip**
 
 
 3. Create the required directory structure.

>**mkdir -p prg/docker**

>**mkdir -p shared/**

>**mkdir -p shared/bkps**



4. Install docker following the commands below


>**sudo apt-get update**

>**sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release**


>**curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg**

>**echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null**


>**sudo apt-get update**

>**sudo apt-get install docker-ce docker-ce-cli containerd.io**


5. Install docker-compose

>**sudo apt-get install docker-compose**
    

6. Create the docker group and add the eip user in it

>**sudo adduser $USER docker**

>**sudo systemctl restart docker.service**



7. Clone the docker project for services configuration

>**cd /home/eip/prg/docker**

>**git clone https://github.com/FriendsInGlobalHealth/centralization-docker-setup.git**



8. Copy the configuration files to the directory shared

>**cp -R /home/eip/prg/docker/centralization-docker-setup/conf /home/eip/shared**



9. Copy the **/home/eip/shared/conf/os/centralization.sh** file to the **/etc/profile.d/ directory**. This file contains environment variables used in docker services. **Example:** access ports to services from the host. Make the necessary changes if you want to modify any service access port.

>**sudo cp /home/eip/shared/conf/os/centralization.sh  /etc/profile.d/**

Then run:

>**source /etc/profile.d/centralization.sh**



11. Make the necessary changes to the files contained in the newly copied conf directory to **/home/eip/shared**.




12. Create the volumes below:

