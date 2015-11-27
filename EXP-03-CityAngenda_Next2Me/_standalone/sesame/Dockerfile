FROM cloudopting/ubuntubase:14.04

MAINTAINER Xavier Cases Camats xavier.cases@worldline.com

#Environment variables
ENV JAVA_OPTS -Xms512m -Xmx2g  -Dinfo.aduna.platform.appdata.basedir=/worldline/tomcat-sesame-cloud4cities/data/aduna
ENV CATALINA_HOME /opt/apache-tomcat/tomcat8
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

#update
RUN apt-get -yq update
#The curl is needed because puppet uses it to retrieve files from internet.
RUN apt-get -yq install curl

#Add wars that has to be deployed
ADD openrdf-sesame.war /tmp/openrdf-sesame.war
ADD openrdf-workbench.war /tmp/openrdf-workbench.war
#Add configuration
ADD aduna /worldline/tomcat-sesame-cloud4cities/data/aduna

#
# PUPPET MODULES
#

#The tomcat module requires puppetlabs-stdlib version 4.0 or newer.
RUN puppet module install puppetlabs-stdlib

#Install latest compatible version
RUN puppet module install puppetlabs-tomcat
RUN puppet module install puppetlabs-java

#Dependencies already installed
#RUN puppet module upgrade puppetlabs-concat
#RUN puppet module upgrade nanliu-staging

#Adding the puppet manifest and executing it.
ADD Manifest.pp /tmp/Manifest.pp
RUN puppet apply /tmp/Manifest.pp

EXPOSE 8080

CMD ["catalina.sh", "run"]
