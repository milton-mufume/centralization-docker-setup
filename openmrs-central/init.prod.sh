#!/bin/sh

apt-get update
apt-get install -y expect

./bin/install_opencr_cert.exp
