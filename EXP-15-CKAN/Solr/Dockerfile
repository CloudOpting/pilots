FROM cloudopting/ubuntubase:14.04
MAINTAINER IMI
RUN apt-get -yq update
ADD Manifest.pp /tmp/Manifest.pp
RUN puppet apply /tmp/Manifest.pp
EXPOSE 8983
WORKDIR /opt/solr/example
CMD ["java", "-jar", "start.jar"]
