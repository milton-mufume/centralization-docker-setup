#!/bin/sh
# description: This shell is intended to generate an certificate for a given URL 
#

timestamp=`date +%Y-%m-%d_%H-%M-%S`
URL=$1
CERT_FILE=$2

echo "GENERATING CERTIFICATE USING URL: $URL"

echo "Q" | openssl s_client -connect $URL | openssl x509 > $CERT_FILE

echo "CERTIFICATE GENERATED!"
