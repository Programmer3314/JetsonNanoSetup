#!/bin/bash

source parameters.sh

echo
echo Jetson Nano Setup
echo

echo
echo Add Swapfile
echo
cd ~/
sudo fallocate -l 4G /var/swapfile
sudo chmod 600 /var/swapfile
sudo mkswap /var/swapfile
sudo swapon /var/swapfile
sudo bash -c 'echo "/var/swapfile swap swap defaults 0 0" >> /etc/fstab'
free -h
read -p "End create swap file..."

echo
echo Make dataroot directory and rights
sudo mdkir /$DATAHOME
cd $DATAHOME
sudo chown -R $PRIMARYUSER /$DATAHOME
sudo chown -R $PRIMARYUSER $SCRIPTROOT



echo
echo Setup Samba Network Access to Team Directory
echo
source samba_setup.sh

echo
echo Setup virtual environment tensorflow_gpu
echo 
cd ~/
sudo apt-get --assume-yes install virtualenv
python3 -m virtualenv -p python3 tensorflow_gpu
source ~/tensorflow_gpu/bin/activate
read -p "Press a key..."


echo
echo Setup TensorFlow
echo 
cd ~/
source ~/tensorflow_gpu/bin/activate
sudo apt-get --assume-yes install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
sudo apt-get --assume-yes install python3-pip
sudo pip3 install -U pip testresources setuptools
sudo pip3 install -U numpy==1.16.1 future==0.17.1 mock==3.0.5 h5py==2.9.0 keras_preprocessing==1.0.5 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
sudo pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 tensorflow-gpu==1.13.1+nv19.5
read -p "Press a key..."

echo
echo Setup TensorFlow Object Detection API
echo
#cd ..
#git clone https://github.com/tensorflow/models.git

#mv ./JetsonNanoSetup/objectdetectiontools ./
