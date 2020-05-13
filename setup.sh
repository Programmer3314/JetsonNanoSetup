#!/bin/bash

PRIMARYUSER=rich
TEAMNUMBER=3314
REMOTEPASSWORD=xxxxx

echo Jetson Nano Setup

sudo apt-get update
sudo apt-get install samba
Y

sudo smbpasswd -a $PRIMARYUSER
$REMOTEPASSWORD
$REMOTEPASSWORD

sudo cp /etc/samba/smb.conf /etc/samba/smb.confBACKUP

#copy config file addition
sudo service smbd restart
