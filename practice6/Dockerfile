FROM ubuntu:20.04

# устанавливаем все необходимые пакеты
RUN apt update && apt install -y \
  default-jdk \
  apt install -y tomcat9 \
  maven \
  git && \
# клонируем репозиторий с boxfuse
  cd home; \
  git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git; \
# переходим в директорию с файлом pom.xml, начинаем сборку
  cd boxfuse-sample-java-war-hello; \
  mvn package; \
# копируем исполняемый файл в директорию tomcat'а
  cp target/hello-1.0.war /var/lib/tomcat9/webapps/ \

# открываем порт 8080
EXPOSE 8080

# Копируем файлы конфигурации необхоидимые catalin'е и создаем папку для временных файлов
cp /dir/server.xml /usr/share/tomcat9/config/ \
cp /dir/web.xml /usr/share/tomcat9/config/ \
cp /dir/logging.properties /usr/share/tomcat9/config/ \
cp /dir/catalina.properties /usr/share/tomcat9/config/ \
cp /dir/tomcat-users.xml /usr/share/tomcat9/config/ \
cp /dir/jaspic-providers.xml /usr/share/tomcat9/config/ \
mkdir /usr/share/tomcat9/conf/

# запускаем tomcat
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]