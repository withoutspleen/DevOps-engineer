### Установка Jenkins:
```shell
apt update
apt install openjdk-11-kre-headless curl -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
apt update
apt install jenkins
```
Пароль для входа:
```shell
cat /var/lib/jenkins/secrets/initialAdminPassword
```
---
### Установка Nexus:

Не забыть открыть порты 8081, 8123

```shell
apt update && apt install docker.io docker-compose -y
```
Подготовка volum'а:
```shell
mkdir data
chown 200:200 data
```
Запускаем `docker-compose.yml` файл `docker-compose up -d`:
```yaml
nexus:
    image: sonatype/nexus3
    ports:
      - "8081:8081"
      - "8123:8123"
    volumes:
      - ./data:/nexus-data
```
Пароль для входа:
```shell
cat data/admin.password
```
Что-бы открыть docker registry заходим в `Administration->Realms` и переносим `Docker Bearer Token Realm` в правую `active` колонку

Создаем docker репозиторий в `repositories`, переопределяем http порт на 8123

---
### Подготовка build и prod серверов:

```shell
apt update && apt install docker.io -y
```
Открываем доступ ssh-подключения через пароль для root:
```shell
nano /etc/ssh/sshd_config
```
```editorconfig
PermitRootLogin yes
PasswordAuthentication yes
```
Разрешаем docker работу с нашим nexus репозиторием:

Добавляем в `/etc/docker/daemon.json`(Если демон отсутствует создать его) следующую строку:
```json
{ "insecure-registries":["host:port"] } 
```
Перезапускаем докер:
```shell
service docker restart
```
Логинимся в Nexus:
```shell
docker login ip:port
```
---
### Задачи для Jenkins:

Создаем параметеризированные сборки со `string parameter` `tag`, для `build`:
```shell
docker build -t prod .
docker tag prod 34.121.40.223:8123/prod:$tag
docker push 34.121.40.223:8123/prod:$tag
```
для `prod`:
```shell
docker pull 34.121.40.223:8123/prod:$tag
docker run -itd -p 8080:8080 34.121.40.223:8123/prod:$tag
```
---
### Скриншоты:

![](IMG/gcp.png?raw=true)

![](IMG/jenkins-jobs.png?raw=true)

![](IMG/jenkins-tag.png?raw=true)

![](IMG/jenkins-build.png?raw=true)

![](IMG/jenkins-prod.png?raw=true)

![](IMG/nexus.png?raw=true)

![](IMG/moba.png?raw=true)

![](IMG/boxfuse.png?raw=true)