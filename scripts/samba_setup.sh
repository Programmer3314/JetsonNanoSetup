#!/bin/bash

source parameters.sh

echo
echo Setup Samba Network Access to Team Directory
echo
apt-get update
apt-get --assume-yes install samba
(echo $REMOTEPASSWORD; echo $REMOTEPASSWORD) | smbpasswd -a -s $PRIMARYUSER
cp /etc/samba/smb.confBACKUP /etc/samba/smb.conf 
cp /etc/samba/smb.conf /etc/samba/smb.confBACKUP
cp $SCRIPTHOME/data/smb.conf_map_team_dir $SCRIPTHOME/data/smb.conf_map_team_dir_updated
sed -i "s/<teamnumber>/$TEAMNUMBER/g" $SCRIPTHOME/data/smb.conf_map_team_dir_updated
sed -i "s/<primaryuser>/$PRIMARYUSER/g" $SCRIPTHOME/data/smb.conf_map_team_dir_updated
cat $SCRIPTHOME/data/smb.conf_map_team_dir_updated >> /etc/samba/smb.conf
service smbd restart
echo End of Samba Network setup
read -p "Press any key to continue..."
