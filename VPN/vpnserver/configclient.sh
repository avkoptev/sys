#!/bin/bash
ipvpnserver="$1"
cp /opt/scripts/sysctl.conf /etc/

if grep "my-server-1" /opt/clients/base.conf>/dev/nul
then
	sed -i 's|my-server-1|'${ipvpnserver}'|' /opt/clients/base.conf
fi
