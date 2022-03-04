## Ansible playbook для работы с AWS:

---
Подготовка среды для правильной работы с плейбуком:
```shell
apt install awscli
aws configure
# access key
# secret key
# region
# json
```
Только после этого устанавливаются следующие пакеты:
```shell
apt update && \
apt install ansible python3-pip -y && \
pip install boto3 boto
```
Далее нужно отредактировать конфигурационный файл ansible
```shell
nano /etc/ansible/ansible.cfg
```
Найти и раскоментировать `host_key_checking = False`