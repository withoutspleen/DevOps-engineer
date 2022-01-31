## Репликации баз данных PostgreSQL

1. Подключение реплики:
Редактируем конфигурационный файл pg_hba.conf, отвечающий за аутентификацию клиентов:
```
nano /etc/postgresql/12/main/pg_hba.conf
```
Добавляем адрес новой реплики следующими строками:
```
host    all             all             ip/mask         md5
host    replication     postgres        ip/mask         md5
# ip - адрес сервар ; mask - маска подсети
```
Перезапускаем сервис:
```
service postgresql restart
```

2. Подготовка реплики:
Установка PostgreSQL:
```
apt install postgresql -y
```
Подготовка директории:
```
cd /etc/lib/postgresql/
rm -rf main/*
pg_basebackup -P -R -X stream -c fast -h ip -U postgres -D ./main
# ip - адрес сервера бд
chown -R postgres:postgres main/
service postgresql restart
```


3. Настройка отложенной репликации:
На реплике, редактируем конфигурационный файл postgresql.conf:
```
nano /etc/postgresql/12/main/postgresql.conf
```
Находим, раскомментируем и меняем следующую строку:
```
recovery_min_apply_delay = 'time'
# time - нужное время, например 6h
service postgresql restart
```

4. Promotion:
На реплике подготавливаем директорию:
```
mkdir dir
# dir = название директории и путь к ней, например /etc/lib/postgresql/12/promote
chown -R postgres:postgres dir/
```
На реплике, выдвигаемой на роль мастер ноды редактируем конфигурационный файл postgresql.conf:
```
nano /etc/postgresql/12/main/postgresql.conf
```
Находим, раскоментируем и меняем следующую строку:
```
promote_trigger_file = '/dir/*'
```
Теперь при появлении любого файла в директории dir, слейв-нода прекратит репликацию и станет мастер-нодой

## Скриншоты:

![](IMG/practice4-1.png?raw=true)

![](IMG/practice4-2.png?raw=true)

![](IMG/practice4-3.png?raw=true)