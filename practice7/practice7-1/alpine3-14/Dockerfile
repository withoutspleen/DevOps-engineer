FROM alpine:3.14
RUN apk add --no-cache mysql-client
RUN apt-get update && \
    apt install tomcat9 \
    cp -r /var/lib/tomcat9/* /usr/share/tomcat9/; \
    rm /usr/share/tomcat9/work; \
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]
