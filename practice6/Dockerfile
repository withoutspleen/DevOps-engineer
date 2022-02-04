FROM ubuntu:20.04

# укажем местоположение, чтобы у устанавливаемых пакетов не возникало вопросов
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# устанавливаем все необходимые пакеты
RUN apt update && apt install -y \
    default-jdk \
    tomcat9 \
    maven \
    git && \
# клонируем репозиторий с boxfuse
    cd home; \
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git; \
# переходим в директорию с файлом pom.xml, начинаем сборку
    cd boxfuse-sample-java-war-hello; \
    mvn package; \
# копируем исполняемый файл в директорию tomcat'а
    cp target/hello-1.0.war /var/lib/tomcat9/webapps/; \
# Копируем файлы конфигурации необхоидимые catalin'е и создаем папку для временных файлов
    mkdir /usr/share/tomcat9/conf; \
    mkdir /usr/share/tomcat9/temp/; \
    cp /etc/tomcat9/server.xml /usr/share/tomcat9/conf/; \
    cp /etc/tomcat9/web.xml /usr/share/tomcat9/conf/; \
    cp /etc/tomcat9/logging.properties /usr/share/tomcat9/conf/; \
    cp /etc/tomcat9/catalina.properties /usr/share/tomcat9/conf/; \
    cp /etc/tomcat9/tomcat-users.xml /usr/share/tomcat9/conf/; \
    cp /etc/tomcat9/jaspic-providers.xml /usr/share/tomcat9/conf/

# открываем порт 8080
EXPOSE 8080

# запускаем tomcat
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]