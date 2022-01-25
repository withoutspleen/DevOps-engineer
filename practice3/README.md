```
cd dir/
# переходим в необходимую директорию
git clone https://repository/repository.git
# клонируем необходимый репозиторий
cd repository/
# переходим в директорию с репозиторием
ll
# проверяем наличие файла pom.xml
mvn package
# запускаем сборку
cd target/
# перехоим в папку с исполняемым файлом
ll
# ищем исполняемый файл с расширением .war
cp hello-war-1.0.war /var/lib/tomcat9/webapps
# копируем исполняемый файл в рабочую директорию tomcat'а
```

Проверить работу веб-приложения можно по адресу ip:port/dir/

ip - адрес сервера

port - порт tomcat'а, по умолчанию 8080

dir - директория приложения, находящаяся в /var/lib/tomcat9/webapps

## Скриншоты:

![](IMG/practice3-1.png?raw=true)
![](IMG/practice3-2.png?raw=true)
![](IMG/practice3-3.png?raw=true)