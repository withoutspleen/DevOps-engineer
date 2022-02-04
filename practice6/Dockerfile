FROM ubuntu:18.04

# укажем местоположение, чтобы у устанавливаемых пакетов не возникало вопросов
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# открываем порт 8080
EXPOSE 8080

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
    cp -r /var/lib/tomcat9/* /usr/share/tomcat9/; \
    rm /usr/share/tomcat9/work/; \
    mkdir -p /usr/share/tomcat9/work/Catalina/localhost/hello-1.0/

# запускаем tomcat
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]