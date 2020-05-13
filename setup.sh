#!/bin/bash

PRIMARYUSER=rich
TEAMNUMBER=3314
REMOTEPASSWORD=xxxxx

echo Jetson Nano Setup

apt-get update
apt-get --assume-yes install samba

(echo $REMOTEPASSWORD; echo $REMOTEPASSWORD) | smbpasswd -a -s $PRIMARYUSER

cp /etc/samba/smb.confBACKUP /etc/samba/smb.conf 
cp /etc/samba/smb.conf /etc/samba/smb.confBACKUP

cat smb.conf_map_team_dir >> /etc/samba/smb.conf

sudo service smbd restart
