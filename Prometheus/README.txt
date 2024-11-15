Для установки запускаем installprometheus.sh из под рута с параметром имя dpkg пакета

После установки:
1) Запускаем /opt/scripts/makepass.sh для установки пароля на prometheus
2) Если необходимо прописать настройки firewall для prometheus сервера запускаем скрипт с правами рута /opt/scripts/iptables.sh

Состав deb пакета:
/opt/scripts/configprometheus.sh
/opt/scripts/makepass.sh
/opt/scripts/web.yml
/opt/scripts/gen-pass.py
/opt/scripts/prometheus.service
/opt/scripts/iptables.sh
/opt/scripts/rules.yml
/opt/scripts/prometheus.yml
/opt/scripts/alertmanager.yml