#!/bin/bash

echo "CREATING THE db/scripts and db/crons DIRECTORIES AT: "$BKP_HOME_DIR

HOME_DIR=$BKP_HOME_DIR

mkdir -p $HOME_DIR/db/crons
mkdir -p $HOME_DIR/scripts

cp crons/* -r $HOME_DIR/db/crons
cp scripts/* -r $HOME_DIR/scripts

cp install_crons.sh $HOME_DIR/db/

/bin/bash $HOME_DIR/db/install_crons.sh


echo "FILES CREATED AT HOME DIRECTORY: "$HOME_DIR