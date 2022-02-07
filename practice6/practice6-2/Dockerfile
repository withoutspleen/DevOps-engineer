FROM tomcat:9.0

# installing packages
RUN apt update && apt install -y \
    maven \
    git && \
# clone boxfuse repo
    cd /; \
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git; \
# start packaging, from directory with pom.xml file
    cd boxfuse-sample-java-war-hello; \
    mvn package; \
# copy war file for tomcat
    cp target/hello-1.0.war /usr/local/tomcat/webapps/; \