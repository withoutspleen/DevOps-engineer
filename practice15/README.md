## Мониторинг веб-прилоежения с Zabbix:

1. Установка Java gateway
```shell
apt install zabbix-java-gateway
```
2. Настройка и запуск Java gateway
```shell
nano /etc/zabbix/zabbix_java_gateway.conf
```

3. Настройка сервера для использования с Java gateway
```shell
nano /etc/zabbix/zabbix_server.conf
```
раскомментировать и настроить строки `JavaGateway` и `JavaGatewayPort`
```text
По умолчанию, сервер нe запускает процессы связанные с мониторингом JMX. Если же вы хотите использовать этот тип мониторинга, то вам нужно указать количество экземпляров Java поллеров. Вы можете это сделать таким же способом как и изменение количества поллеров и трапперов.
```
```text
StartJavaPollers=5
```




##Screenshots:

![](IMG/prometheus-1.png?raw=true)

![](IMG/prometheus-2.png?raw=true)