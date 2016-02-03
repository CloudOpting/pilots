This folder will have a **docker-compose.yml** file that will deploy all components.

The components will have the following features/technologies:
- All the Dockerfiles will be extendiong from some cloudopting base image from docker hub (https://hub.docker.com/u/cloudopting/)
- All the Dockerfiles will ADD a puppet Manifest to install the desired softwoare on the Dockerfile

To deploy it you only have to execute the following command:

```command
docker-compose up
```
