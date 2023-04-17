#!/bin/sh

HOME_DIR="/usr/local/tomcat"

$HOME_DIR/scripts/generate_certificate.sh "opencr:3000" "$HOME_DIR/opencr.cert"
$HOME_DIR/scripts/install_certificate_to_jdk_carcets.sh "$HOME_DIR/opencr.cert"
