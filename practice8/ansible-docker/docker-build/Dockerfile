FROM maven:3.6.1-alpine
RUN apk update; \
    apk add git
RUN cd /tmp/; \
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git; \
    cd boxfuse-sample-java-war-hello; \
    mvn package
WORKDIR /tmp/webapps/
RUN cp /tmp/boxfuse-sample-java-war-hello/target/hello-1.0.war /tmp/webapps/