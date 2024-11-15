#!/bin/bash

cp /opt/scripts/prometheus.yml /etc/prometheus
cp /opt/scripts/alertmanager.yml /etc/prometheus
cp /opt/scripts/web.yml /etc/prometheus
cp /opt/scripts/rules.yml /etc/prometheus
cp /opt/scripts/prometheus.service /etc/systemd/system/multi-user.target.wants/

systemctl daemon-reload
systemctl restart prometheus

