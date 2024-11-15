Для установки необходимых файлов и программ запускаем под правами рута Install_CA.sh с именем deb пакета в параметрах.

После установки:
1) Если необходимо прописать настройки firewall сервера центра сертификации запускаем скрипт с правами рута /opt/scripts/IptablesCA.sh
2) Если необходимо создать корневой сертификат для центра сертификации запускаем скрипт с правами рута /opt/scripts/CreateCertificate.sh
3) Если необходимо подписать сертифкат сервера, запускаем скрипт /opt/scripts/signserver.sh
4) Если необходимо подписать сертификат клиента, запускаем скрипт /opt/scripts/signclient.sh параметром имя клиента

В deb пакете:
/opt/scripts/CreateCertificate.sh
/opt/scripts/IptablesCA.sh
/opt/easy-rsa/vars
/opt/scripts/signserver.sh
/opt/scripts/signclient.sh