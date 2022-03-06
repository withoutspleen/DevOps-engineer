## Ansible playbook для работы с AWS:

---

### Сам [playbook.yml](https://github.com/withoutspleen/DevOps-engineer/blob/main/practice13/ansible/playbook.yml)

---

### Подготовка среды для правильной работы с плейбуком:
```shell
apt install awscli -y &&
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
pip install boto3 boto &&
pip3 install --upgrade awscli
```
Далее нужно отредактировать конфигурационный файл ansible
```shell
nano /etc/ansible/ansible.cfg
```
Найти и раскоментировать `host_key_checking = False`

---
## Screenshots:

![](IMG/moba1.png?raw=true)

![](IMG/moba2.png?raw=true)