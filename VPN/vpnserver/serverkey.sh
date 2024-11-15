#!/bin/bash

ipca="192.168.0.3"

sudo chgrp -R $USER /opt

#Download ca-certificat
scp $USER@"$ipca":/opt/easy-rsa/pki/ca.crt ~/
sudo mv ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

cd /opt/easy-rsa/
/opt/easy-rsa/easyrsa gen-req server nopass
sudo cp /opt/easy-rsa/pki/private/server.key /etc/openvpn/server
scp /opt/easy-rsa/pki/reqs/server.req scp $USER@"$ipca":/tmp/

mkdir /opt/easy-rsa/pki/issued
chmod -R 770 /opt/easy-rsa/pki/issued