Для установки запускаем installvpnserver.sh из под рута с параметром имя dpkg пакета

Донастройка:
1) Запустить /opt/scripts/serverkey.sh для запроса сертифката на сервер
2) Запускаем с правами рута /opt/scripts/configclient.sh с параметром IP VPN для прописывания ип в конфиге клиента и копирования некоторых конфигурационных файлов.
3) После получения подписанного сертификата сервера запустить скрипт с правами рута /opt/scripts/startupvpn.sh для запуска сервера в автозагрузку
3) Если необходимо прописать настройки firewall VPN сервера запускаем скрипт с правами рута /opt/scripts/IptablesCA.sh, в параметрах указываем протокол и порт

После установки:
1) Если необходимо сгенерировать клиентский ключ запускаем скрипт /opt/scripts/clientkey.sh с параметром имя клиента. Скрипт отправляет запрос на сервер сертифкации
2) Для получения файла конфигурации подключения для клиента, после получения подписаного сертификата запускаем скрипт /opt/scripts/makeconfig.sh с параметром имя клиента. Сгененрированный файл будет в /opt/clients/files 

Состав deb пакета:
/opt/clients/base.conf
/etc/openvpn/server/server.conf
/opt/scripts/sysctl.conf
/opt/scripts/iptables.sh
/opt/scripts/clientkey.sh
/opt/scripts/startupvpn.sh
/opt/scripts/serverkey.sh
/opt/scripts/configclient.sh
/opt/scripts/makeconfig.sh
/etc/systemd/system/openvpn_exporter.service