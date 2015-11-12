# Docker related recommendations


### Advices

#### Apply restart policies

Usually, containers are associated with daemon processes. The container life-cycle is determined by the daemon status, i.e.: you start a container with a daemon and when the daemon exits, the container also stop.

As a result, it is common to deploy containerized applications with something that monitor the container status and re-launch it if it fails. In _docker_, a way to do this is the native [__restart policies__](http://docs.docker.com/engine/reference/run/#restart-policies-restart) feature.

This let you specify if a container should be re-launched _never_, _when exit on error_ or _always_.

Unless your container is a data-only container or a one-shot app, the better is to choose _always_.

Since in _CloudOpting_ we are using the [_docker-compose yaml_](http://docs.docker.com/compose/compose-file/#cpu-shares-cpuset-domainname-entrypoint-hostname-ipc-mac-address-mem-limit-memswap-limit-privileged-read-only-restart-stdin-open-tty-user-working-dir) specification, this can be done with the `restart` directive:

```yaml
containername:
  image: reponame/imageservice
  restart: always
```
