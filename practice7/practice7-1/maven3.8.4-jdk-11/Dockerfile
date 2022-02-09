FROM maven:3.8.4-jdk-11
RUN apt-get update; \
    apt install git;
RUN cd /tmp/ ; \
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git; \
    cd boxfuse-sample-java-war-hello; \
    mvn package;
