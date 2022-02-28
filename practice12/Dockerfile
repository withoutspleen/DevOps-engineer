FROM ubuntu:16.04
RUN apt update
RUN apt install -y \
    openjdk-8-jdk \
    maven \
    git
RUN cd /root &&
    git clone https://github.com/shephertz/App42PaaS-Java-MySQL-Sample.git && cd App42PaaS-Java-MySQL-Sample && \
    mvn package