FROM cloudopting/ubuntubase:14.04
MAINTAINER Ciprian Pavel "ciprian.pavel@teamnet.ro"

RUN echo '#!/bin/bash\necho "N 2"\n' > /sbin/runlevel
RUN chmod 755 /sbin/runlevel

RUN apt-get -yq update

RUN puppet module install puppetlabs-apache
RUN puppet module install puppetlabs-mysql

ADD wordpress-4.2.5.tar.gz /tmp/wordpress.tar.gz
ADD exp10.pp /tmp/exp10.pp
ADD wp-config.php.erb /tmp/wp-config.php.erb

RUN puppet apply /tmp/exp10.pp

# OPEN UP PORT
EXPOSE 80

# START APACHE
#ENTRYPOINT [ "/usr/sbin/apache2","-D", "FOREGROUND" ]
