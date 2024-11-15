#!/bin/bash

ipca="192.168.0.3"
name="$1"

cd /opt/easy-rsa/
/opt/easy-rsa/easyrsa gen-req "$name" nopass
cp /opt/easy-rsa/pki/private/"$name".key /opt/clients/key
scp /opt/easy-rsa/pki/reqs/"$name".req scp $USER@"$ipca":/home/$USER
