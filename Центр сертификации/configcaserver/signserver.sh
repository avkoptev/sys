#!/bin/bash
ipvpn="10.131.0.31"
cd /opt/easy-rsa/
cp /tmp/server.req /opt/easy-rsa/pki/reqs/
/opt/easy-rsa/easyrsa sign-req server server
scp /opt/easy-rsa/pki/issued/server.crt $USER@"$ipvpn":/opt/easy-rsa/pki/issued
