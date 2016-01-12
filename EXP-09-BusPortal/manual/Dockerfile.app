FROM java:8
VOLUME /tmp
ADD ./busportal-0.1-SNAPSHOT.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Dspring.datasource.url=jdbc:mysql://exp09-db:3306/busportal","-jar","/app.jar"]
