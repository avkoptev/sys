#!/bin/bash
chgrp -R $USER /opt
cd /opt/easy-rsa
./easyrsa build-ca
cp /opt/easy-rsa/pki/ca.crt /usr/local/share/ca-certificates/
echo "Your new CA certificate file for publishing is at:"
echo "/usr/local/share/ca-certificates/ca.crt"

