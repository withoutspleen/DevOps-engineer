FROM ubuntu:18.04
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
  cp target/hello-1.0.war /var/lib/tomcat9/webapps/
# открываем порт 8080 \
EXPOSE 8080
# запускаем tomcat
CMD ["catalina.sh", "run"]