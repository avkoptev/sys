#!/bin/bash
namekey="$1"
ipvpn="10.131.0.31"
cd /opt/easy-rsa/
cp /home/$USER/"$namekey".req /opt/easy-rsa/pki/reqs/
/opt/easy-rsa/easyrsa sign-req client "$namekey"
scp /opt/easy-rsa/pki/issued/"$namekey".crt $USER@"$ipvpn":/opt/clients/key
