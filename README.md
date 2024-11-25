# Описание проекта
Скрипты для развертывания инфраструктуры в рамках финальной работы курса «Системное администрирование для начинающих».

Содержит сервер сертификации, сервер сбора метрик и vpn-сервер

# Развертывание
Вся документациия содержится в папке /Документация

## Сервер сертификации:
1)	Для сервера сертификации создается отдельная подсеть 192.168.0.0/28, в группе безопасности перекрываем все порты для подсети кроме 22, 443, 53, 80, 9100. Локальный IP адрес устанавливаем 192.168.0.3. 
2)	С корпоративного гитлаба закачиваем на сервер пакет configcaserver и скрипт Install_CA.sh. Для развертывания сервера используем скрипт Install_CA.sh:
```shell
Sudo ./Install_CA.sh configcaserver_0.1-4_all.deb
```
В качестве параметра используется имя пакета. Скрипт установит easy-rsa, утилиту для iptables, а также экспортер. Помимо этого, в папку /opt/scripts скопируются скрипты для автоматизации некоторых работ на сервере.
3)	Запускаем скрипт с правами рута /opt/scripts/IptablesCA.sh для закрытия всех портов на сервере кроме 22 и 9100 (только для Prometheus сервера):
```shell
Sudo /opt/scripts/IptablesCA.sh
```
4)	Запускаем скрипт /opt/scripts/CreateCertificate.sh для создания корневого сертификата:
```shell
/opt/scripts/CreateCertificate.sh
```
Если сертификат создался, развертывание прошло успешно.

## VPN-сервер:
1)	Для vpn-сервера используется дефолтная подсеть default-ru-central1-d 10.131.0.0/24. Локальный IP адрес устанавливаем 10.131.0.31. 
2)	С корпоративного гитлаба закачиваем на сервер пакет vpnserver и скрипт installvpnserver.sh. Для развертывания сервера используем скрипт installvpnserver.sh:
```shell
Sudo ./installvpnserver.sh vpnserver_0.1-4_all.deb
```
В качестве параметра используется имя пакета. Скрипт установит easy-rsa, openvpn, утилиту для iptables, экспортер для узла и openvpn, а также golang необходимый для работы экспортера openvpn. Помимо этого, в папку /opt/scripts скопируются скрипты для автоматизации некоторых работ на сервере.
3)	Дальнейшая настройка сервера требует настройку ssh соединения между vpn-сервером и ca-сервером, проводящаяся вручную. Предполагается что соединение будет настроено для текущего пользователя.
4)	Запускаем скрипт /opt/scripts/serverkey.sh:
```shell
/opt/scripts/serverkey.sh
```
Скрипт скачает корневой сертификат, создаст и отправит запрос на подписание на сервер сертификации. После этого на сервере сертификации надо будет запустить скрипт создания серверного сертификата. Сертификат автоматически будет отправлен на сервер VPN
5)	Запускаем с правами рута скрипт /opt/scripts/configclient.sh:
```shell
Sudo /opt/scripts/configclient.sh 158.160.144.239
```
В качестве параметра использует внешний IP адрес vpn-сервера. Скрипт перенесет необходимые конфигурационные файлы.
6)	Запускаем с правами рута скрипт /opt/scripts/startupvpn.sh
```shell
Sudo /opt/scripts/startupvpn.sh
```
Скрипт сохранит полученный серверный сертификат и запустит openvpn-server@server.service
7)	Запускаем с правами рута скрипт /opt/scripts/iptables.sh
```shell
Sudo /opt/scripts/iptables.sh udp 1194
```
Скрипт требует в параметрах протокол и порт, прописывает туннелирование и закрытие всех портов кроме 22, 80, 443, 1194, 9100 (только для Prometheus сервера), 9176 (только для Prometheus сервера) в iptables. 
Если все прошло успешно, то можно установить впн-туннель к серверу с помощью клиента openvpn.
Создание сертификатов пользователей будет в разделе ниже.

## Prometheus сервер:
1)	Для prometheus-сервера используется дефолтная подсеть default-ru-central1-d 10.131.0.0/24. Локальный IP адрес устанавливаем 10.131.0.21. 
2)	С корпоративного гитлаба закачиваем на сервер пакет prometheusserver и скрипт installprometheus.sh. Для развертывания сервера используем скрипт installprometheus.sh:
```shell
Sudo ./ installprometheus.sh prometheusserver_0.1-3_all.deb
```
В качестве параметра используется имя пакета. Скрипт установит prometheus, утилиту для iptables, alertmanager, экспортер для узла, а также python3-bcrypt необходимый для работы шифрования пароля. Помимо этого, в папку /opt/scripts скопируются скрипты для автоматизации некоторых работ на сервере.
3)	Запускаем с правами рута скрипт /opt/scripts/iptables.sh
```shell
Sudo /opt/scripts/iptables.sh
```
Скрипт закроет все порты кроме 22, 80, 443, 9090
4)	Запускаем скрипт с правами рута /opt/scripts/makepass.sh:
```shell
Sudo /opt/scripts/makepass.sh
```
Скрипт предложит придумать пароль для учетной записи admin и установит его.
Если все прошло успешно, то по адресу Prometheus:9090 будет доступна web версия сбора метрик со снимаемыми со всех серверов метрик.

## Подпись сертификатов:
### Подпись серверного сертификата:
1)	Запускаем на vpn-сервере скрипт /opt/scripts/serverkey.sh:
```shell
/opt/scripts/serverkey.sh
```
Скрипт скачает корневой сертификат, создаст и отправит запрос на подписание на сервер сертификации. 
2)	Запускам на ca-сервере скрипт /opt/scripts/signserver.sh
```shell
/opt/scripts/signserver.sh
```
Скрипт создаст сертификат и отправит его сервер vpn
### Подпись клиентского сертификата и создание файла .ovpn:
1)	Запускаем на vpn-сервере скрипт /opt/scripts/clientkey.sh:
```shell
/opt/scripts/clientkey.sh ivan
```
Скрипт требует в параметрах указать имя клиента. Он создаст и отправит запрос на подписание на сервер сертификации. 
2)	Запускам на ca-сервере скрипт /opt/scripts/signclient.sh
```shell
/opt/scripts/signclient.sh ivan
```
Скрипт требует в параметрах указать имя клиента. Он создаст сертификат и отправит его сервер vpn
3)	Запускаем на vpn-сервере /opt/scripts/makeconfig.sh
```shell
/opt/scripts/makeconfig.sh ivan
```
Скрипт требует в параметрах указать имя клиента. Он создаст файл настроек ivan.ovpn с именем пользователя, который необходимо передать пользователю для подключения его к vpn.

