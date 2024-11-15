#!/bin/bash
namedpkg="$1"

#install easy-rsa and openvpn
apt update
apt install easy-rsa openvpn iptables-persistent prometheus-node-exporter golang

#Checking installation sucess
if [ $? -ne 0 ]
then
	echo "The installation failed. Scripts execution stopped"
	exit 1
fi

#install openvpn_exporter
wget https://github.com/kumina/openvpn_exporter/archive/refs/tags/v0.3.0.tar.gz
tar xzf v0.3.0.tar.gz
cd openvpn_exporter-0.3.0/
sed -i 's|"examples/client.status,examples/server2.status,examples/server3.status"|"/var/log/openvpn/openvpn-status.log"|' main.go
go build -o openvpn_exporter main.go
cp openvpn_exporter /usr/local/bin

#Creating a work folder
mkdir /opt/easy-rsa
ln -s /usr/share/easy-rsa/* /opt/easy-rsa/
chmod 770 /opt/easy-rsa

#Checking the creation of a work folder
if [ ! -d /opt/easy-rsa ]
then
	echo "Work folder not creating! Script execution stopped"
	exit 1
fi

mkdir /opt/scripts/

#Create key for TLC
/usr/sbin/openvpn --genkey --secret ta.key
cp ta.key /etc/openvpn/server

#Create dir for clients
mkdir -p /opt/clients/key
chmod -R 770 /opt/clients/

#Install dpkg-package
dpkg -i "$namedpkg"
sysctl -p
systemctl daemon-reload
systemctl enable --now openvpn_exporter.service
chmod -R 770 /opt/scripts/

#Create pki
cd /opt/easy-rsa/
/opt/easy-rsa/easyrsa init-pki


