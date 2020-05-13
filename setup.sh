#!/bin/bash

PRIMARYUSER=rich
TEAMNUMBER=3314
REMOTEPASSWORD=xxxxx

echo
echo Jetson Nano Setup
echo

echo
echo Setup Samba Network Access to Team Directory
echo
apt-get update
apt-get --assume-yes install samba
(echo $REMOTEPASSWORD; echo $REMOTEPASSWORD) | smbpasswd -a -s $PRIMARYUSER
cp /etc/samba/smb.confBACKUP /etc/samba/smb.conf 
cp /etc/samba/smb.conf /etc/samba/smb.confBACKUP
cp smb.conf_map_team_dir smb.conf_map_team_dir_updated
sed -i "s/<teamnumber>/$TEAMNUMBER/g" smb.conf_map_team_dir_updated
sed -i "s/<primaryuser>/$PRIMARYUSER/g" smb.conf_map_team_dir_updated
cat smb.conf_map_team_dir_updated >> /etc/samba/smb.conf
sudo service smbd restart
