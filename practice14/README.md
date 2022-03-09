## [Манифест](https://github.com/withoutspleen/DevOps-engineer/blob/main/practice14/tf/config.tf)

---
## Установка Google Cloud CLI:

[Official installing page](https://cloud.google.com/sdk/docs/install#linux
)

[Official startup page](https://cloud.google.com/sdk/gcloud/reference/topic/startup)

#### Универсальная установка для Linux x64

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
rm google-cloud-sdk-375.0.0-linux-x86_64.tar.gz
```
```shell
./google-cloud-sdk/install.sh
```
4. Для инициализации `gcloud` CLI, запустить gcloud init:
```shell
gcloud init
# ./google-cloud-sdk/bin/gcloud init
```

#### Установка Debuan/Ubuntu:

```shell
sudo apt-get install apt-transport-https ca-certificates gnupg
```
```shell
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
```
```shell
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
```
```shell
sudo apt-get update && sudo apt-get install google-cloud-cli
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
