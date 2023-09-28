#!/bin/bash

server_host='localhost'
server_port=$SANTE_DB_MPI_MAIN_PORT
client_id=$1
security_id=$2
client_secret=$3
SCRIPT_LOCATION=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


cd $SCRIPT_LOCATION
cd ..

home_dir=$(pwd)


data_dir="$home_dir/etc/entity-domain"
data_file="$data_dir/assign-authority-template"


host_url="http://${server_host}:${server_port}"
outh_url="${host_url}/auth/oauth2_token"
assign_authority_url="${host_url}/hdsi/Bundle"


echo "Starting assign authority task" 

if [ -z $client_id ] || [ -z $security_id ] || [ -z $client_secret ]; then
	echo "One or more param have empty value you must specify the params as following..."
	echo "./assign_authority.sh client_id security_id client_secret"
	exit 1
fi

echo "Using Home dir: $home_dir"
echo "      Data_file: $data_file"
echo "      Base url: $host_url"
echo "      Client_id: $client_id"          
echo "      Security_id: $security_id"          
echo "      Client_secret: $client_secret"          
echo "	    outh_url: $outh_url"
echo "	    assign_authority_url: $assign_authority_url"

echo "Generating token..."

curl 	-X POST \
	-L "$outh_url" \
	-H "Content-Type: application/x-www-form-urlencoded" \
	--data-urlencode "grant_type=client_credentials" \
	--data-urlencode "scope=*" \
	--data-urlencode "client_secret=${client_secret}" \
	--data-urlencode "client_id=$client_id" | jq -r ".access_token" > token.txt

token=$(cat token.txt)

echo "Token Generated: [${token}]"

echo "Assigning Authority..."

cp $data_file tmp_data.xml

sed -i "s/{{security_id}}/$security_id/g" tmp_data.xml

data=$(cat tmp_data.xml)

curl -L "$assign_authority_url" \
--header "Authorization: Bearer $token" \
--header 'Content-Type: application/xml' \
--data "$data"

rm tmp_data.xml
rm token.txt
