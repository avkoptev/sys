#!/bin/bash
namekey="$1"
KEY_DIR=/opt/clients/key
OUTPUT_DIR=/opt/clients/files
BASE_CONFIG=/opt/clients/base.conf

#Copy ta.key
if [ ! -e /opt/clients/key/ta.key ]
then
	cp /etc/openvpn/server/ta.key /opt/clients/key/ta.key
fi

#Make dir for config
if [ ! -d /opt/clients/files ]
then
	mkdir /opt/clients/files
fi

#Fixing access
sudo chgrp -R $USER /opt/clients/
sudo chmod -R 770 /opt/clients/

#Make config
cat ${BASE_CONFIG} \
<(echo -e '<ca>') \
/usr/local/share/ca-certificates/ca.crt \
<(echo -e '</ca>\n<cert>') \
${KEY_DIR}/"$namekey".crt \
<(echo -e '</cert>\n<key>') \
${KEY_DIR}/"$namekey".key \
<(echo -e '</key>\n<tls-crypt>') \
${KEY_DIR}/ta.key \
<(echo -e '</tls-crypt>') \
> ${OUTPUT_DIR}/"$namekey".ovpn
