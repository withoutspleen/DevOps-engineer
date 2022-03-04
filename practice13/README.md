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

```shell
apt update && \
apt install ansible python3-pip -y && \
pip install boto3 boto
```
