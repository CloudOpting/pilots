Docker files are provided for convenience as the images are pushed to Docker registry.
The result is available at http://exp09.cloudapp.net/

The Service is using three Docker containers:
 - exp09-web - Apache Web server as reverse proxy for standalone Spring Boot based container; it is used to forward Apache logs to Fluend server; exposes port 80 to the host machine
 - exp09-app - SpringBoot standalone application running the main application logic; exposes port 8080 to the exp09-web container
 - exp09-db  - MySQL based database to provide persistence for the service; exposes port 3306 to the exp09-app container

