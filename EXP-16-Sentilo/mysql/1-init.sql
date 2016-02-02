CREATE USER 'sentilo_user'@'localhost' IDENTIFIED BY 'sentilo_pwd';
CREATE DATABASE sentilo;
USE sentilo;
GRANT ALL PRIVILEGES ON sentilo.* TO 'sentilo_user'@'localhost';
