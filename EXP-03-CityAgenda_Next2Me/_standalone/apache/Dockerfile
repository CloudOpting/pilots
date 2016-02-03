FROM cloudopting/ubuntubase:14.04

MAINTAINER Xavier Cases Camats xavier.cases@worldline.com

#Environment variables
ENV HTTPD_PREFIX /usr/local/apache2
ENV PATH $PATH:$HTTPD_PREFIX/bin
RUN mkdir -p "$HTTPD_PREFIX" \
	&& chown www-data:www-data "$HTTPD_PREFIX"
WORKDIR $HTTPD_PREFIX

#update
RUN apt-get -yq update

#Add configuration
ADD data /usr/local/apache2/htdocs
ADD httpd.conf /usr/local/apache2/conf/httpd.conf
ADD users.userdb /usr/local/apache2/conf/users.userdb

#
# PUPPET MODULES
#

#Install latest compatible version
RUN puppet module install puppetlabs-apache

#Adding the puppet manifest and executing it.
ADD Manifest.pp /tmp/Manifest.pp
RUN puppet apply /tmp/Manifest.pp

EXPOSE 80
EXPOSE 443

CMD ["httpd -DFOREGROUND"]
