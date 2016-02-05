FROM java:8
VOLUME /tmp
ADD ./energydashboard-0.1-SNAPSHOT.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Dspring.datasource.url=jdbc:mysql://exp08-db:3306/energydashboard?useUnicode=true&characterEncoding=utf8","-jar","/app.jar"]
