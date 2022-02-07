FROM ubuntu:18.04

# initialize location (for Ubuntu 20.04 only)
    # ENV TZ=Europe/Moscow
    # RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# open 8080 port
EXPOSE 8080

# installing packages
RUN apt update && apt install -y \
    default-jdk \
    tomcat9 \
    maven \
    git && \
# clone boxfuse repo
    cd home; \
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git; \
# start packaging, from directory with pom.xml file
    cd boxfuse-sample-java-war-hello; \
    mvn package; \
# copy war file for tomcat
    cp target/hello-1.0.war /var/lib/tomcat9/webapps/; \
# share tomcat files with catalina
    cp -r /var/lib/tomcat9/* /usr/share/tomcat9/; \
    rm /usr/share/tomcat9/work; \
    mkdir -p /usr/share/tomcat9/work/Catalina/localhost/hello-1.0/

CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]