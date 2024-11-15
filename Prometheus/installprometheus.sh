#!/bin/bash
namedpkg="$1"

#install prometheus and prometheus-alertmanager
apt update
apt install prometheus iptables-persistent prometheus-alertmanager prometheus-node-exporter python3-bcrypt -y

#Checking installation sucess
if [ $? -ne 0 ]
then
	echo "The installation failed. Scripts execution stopped"
	exit 1
fi

#Create dir for scripts
mkdir /opt/scripts/ 

#Create TLS-cert
mkdir /opt/prometheus_tls
cd /opt/prometheus_tls
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout prometheus.key -out prometheus.crt -subj "/C=BE/ST=Antwerp/L=Brasschaat/O=Inuits/CN=localhost" -addext "subjectAltName = DNS:localhost"
chmood -R 707 /opt/prometheus_tls

#Install dpkg-package
dpkg -i "$namedpkg"
/opt/scripts/configprometheus.sh


chmod -R 770 /opt/scripts/




