FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG WAR_FILE
ADD ${WAR_FILE} app.war
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.war"]