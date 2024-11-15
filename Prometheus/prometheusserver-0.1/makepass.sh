#!/bin/bash

pass=$(python3 /opt/scripts/gen-pass.py)

sed -i "/admin:*/c\    admin: '$pass'" /etc/prometheus/web.yml

systemctl restart prometheus

