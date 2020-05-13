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
service smbd restart


echo
echo Setup TensorFlow
echo 
sudo apt-get --assume-yes install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
sudo apt-get --assume-yes install python3-pip
sudo pip3 install -U pip testresources setuptools
sudo pip3 install -U numpy==1.16.1 future==0.17.1 mock==3.0.5 h5py==2.9.0 keras_preprocessing==1.0.5 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow
