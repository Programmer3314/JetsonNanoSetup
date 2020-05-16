# JetsonNanoSetup
setup scripts for Jetson Nano

Develop setup scripts to rebuild Nano from a new image
Image: nv-jetson-nano-sd-card-image-r32.2.3.zip
Flash image with balenaEtcher.

On startup:
Accept Licenses
Select Language (English)
Confirm Keyboard (English (US))
Set Timezone (New York) 
Set User/Computer Name and password
- Computer Name: nano3314
- Select login automatically
APP Partion Size: use default max size

The system will then do the initial configuration. 
Review Gnome initial setup options: 
- skip livepatch to avoid automatic updates
- do not send system info to avoid extra communications

Edit ethernet connection and set static address.
If prompted set keyring password.

Install and configure file sharing. 
Run the following commands in Terminal:
# create team directory
sudo mkdir /<team number>
(enter password for primary user created above)
# take ownership of directory
sudo chown <primary user> /<team number>
# install samba
sudo apt-get update
sudo apt-get install samba
(continue? Y)
# set primary user remote password  
sudo smbpasswd -a <primary user>
  <remote password>
  <remote password>
# configure remote share    
sudo cp /etc/samba/smb.conf /etc/samba/smb.confBACKUP

Use the file explorer to navigate to /etc/samba/ and edit the smb.conf file adding the following lines at the bottom:
[<teamnumber>]
path = /<teamnumber>
valid users = <primary user>
read only = no

Back in terminal run:
sudo service smbd restart
