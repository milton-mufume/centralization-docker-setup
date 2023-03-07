#!/bin/sh

apt-get update
apt-get install -y expect

./bin/generate_certificate.sh "opencr:3000" "/usr/local/tomcat/opencr.cert"
./bin/install_certificate_to_jdk_carcets.sh "/usr/local/tomcat/opencr.cert"
