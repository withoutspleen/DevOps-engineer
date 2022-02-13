FROM maven:3.6.1-alpine
RUN apk update; \
    apk add git
RUN cd /tmp/; \
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git; \
    cd boxfuse-sample-java-war-hello; \
    mvn package
CMD /bin/sh