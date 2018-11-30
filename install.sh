#!/bin/bash

# install script for sstub

echo "installing sstub ..."

# create var for logged in user
me=$(whoami)

# work in scractch
cd /scratch/$me

echo "downloading source ..."

# grap archive and unzip
wget -O sstub.zip https://github.com/uvasomrc/sstub/archive/master.zip > /dev/null 2>&1
unzip sstub.zip > /dev/null 2>&1

echo "adding executable to PATH ..."

# make directory for home bin if it's not there
mkdir -p /home/$me/bin

# move sstub to home bin and make executable
mv sstub-master/sstub.sh /home/$me/bin/sstub
chmod +x /home/$me/bin/sstub

# add home bin to user path
echo "export PATH=$PATH:/home/$me/bin" >> ~/.bashrc
source ~/.bashrc

echo "cleaning up ..."

# clean up
rm -rf sstub-master
rm sstub.zip

echo "done."
