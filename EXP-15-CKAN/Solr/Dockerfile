FROM cloudopting/ubuntubase:14.04
MAINTAINER IMI
RUN echo '#!/bin/bash\necho "N 2"\n' > /sbin/runlevel
RUN chmod 755 /sbin/runlevel
RUN apt-get -yq update
ADD Manifest.pp /tmp/Manifest.pp
RUN puppet apply /tmp/Manifest.pp
EXPOSE 8983
WORKDIR /opt/solr/example
CMD ["java", "-jar", "start.jar"]
