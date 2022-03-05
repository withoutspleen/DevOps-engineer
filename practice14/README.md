## Установка Google Cloud CLI

[Official installing page](https://cloud.google.com/sdk/docs/install#linux
)

[Official startup page](https://cloud.google.com/sdk/gcloud/reference/topic/startup)

1. Установить python 3:
```shell
apt update && \
apt install python3
```
2. Скачать  64-битный архив для Linux:
```shell
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-375.0.0-linux-x86_64.tar.gz
```
3. Распаковать архив, запустить `install.sh`:
```shell
tar -xf google-cloud-sdk-375.0.0-linux-x86_64.tar.gz && \
rm google-cloud-sdk-375.0.0-linux-x86_64.tar.gz && \
./google-cloud-sdk/install.sh
```
4. Для инициализации `gcloud` CLI, запустить gcloud init:
```shell
gcloud init
# ./google-cloud-sdk/bin/gcloud init
```
---
## Полезные команды:

Для получения имени образа системы, который будет исопльзоваться в `config.tf`, можно 
воспользоваться командой:
```shell
gcloud compute images list
```
Например образ `Ubuntu 20.04 LTS` будет выглядеть как:
```
ubuntu-os-cloud/ubuntu-2004-lts
```
