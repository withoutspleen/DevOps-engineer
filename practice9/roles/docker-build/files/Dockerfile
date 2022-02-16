FROM maven:3.8.4-jdk-11 as build
COPY . .
RUN apt-get update; \
    apt install git;
RUN cd /tmp/ ; \
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git; \
    cd boxfuse-sample-java-war-hello; \
    mvn package
FROM jetty:9.3.21-alpine as production
EXPOSE 8080
COPY --from=build /tmp/boxfuse-sample-java-war-hello/target/ /var/lib/jetty/webapps/
