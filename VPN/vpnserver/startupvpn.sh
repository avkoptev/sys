#!/bin/bash
cp /opt/easy-rsa/pki/issued/server.crt /etc/openvpn/server
systemctl -f enable openvpn-server@server.service
systemctl start openvpn-server@server.service
systemctl status openvpn-server@server.service
