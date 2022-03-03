FROM maven:3.8.4-openjdk-8-slim
RUN apt update && apt install -y git
RUN cd /tmp/ ; \
    git clone https://github.com/withoutspleen/test1.git && \
    cd test1 ; \
    mvn package ;