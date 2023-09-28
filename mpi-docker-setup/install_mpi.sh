#!/bin/bash
# This scrip is intended to install sante MPI server 

ENV_FILE="mpi.env"

echo "Loading .env file"

if [ -f "$ENV_FILE" ]; then
    
    source "$ENV_FILE"
    echo "The .env file as been loaded successfuly"
else
    echo "The env file is empty, aborting the installation"
    exit 1
fi

docker volume create santedb-data

docker-compose up -d

docker logs --follow santedb-mpi
