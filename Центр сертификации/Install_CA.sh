#!/bin/bash
namedpkg=$1

#Install easy-rsa
apt update
apt install easy-rsa iptables-persistent prometheus-node-exporter

#Checking installation success
if  [ $? -ne 0 ]
then
	echo "The installation failed. Script execution stopped"
	exit 1
fi

#Creating a work folder
mkdir /opt/easy-rsa
ln -s /usr/share/easy-rsa/* /opt/easy-rsa/
chmod -R 770 /opt/easy-rsa

#Checking the creation of a work folder
if [ ! -d /opt/easy-rsa  ]
then
	echo "Work folder not creating! Script execution stopped"
	exit 1
fi

mkdir /opt/scripts/


#Instal dpkg-package
dpkg -i "$namedpkg"

chmod -R 770 /opt/scripts/
cd /opt/easy-rsa/
/opt/easy-rsa/easyrsa init-pki 

