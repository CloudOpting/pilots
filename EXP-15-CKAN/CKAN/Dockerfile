FROM cloudopting/ubuntubase:14.04
MAINTAINER IMI
RUN apt-get -yq update
ADD Manifest.pp /tmp/Manifest.pp
ADD production.ini.erb /tmp/production.ini.erb
RUN puppet apply /tmp/Manifest.pp
EXPOSE 80
CMD (cd /usr/lib/ckan/default/src/ckan ; paster serve /etc/ckan/default/production.ini)
