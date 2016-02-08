#FROM cloudopting/centosbase:7
FROM cloudopting/ubuntubase:14.04

MAINTAINER Xavier Cases Camats xavier.cases@worldline.com

#Environment variables
ENV JAVA_OPTS="-Xms512m -Xmx2g -Dinfo.aduna.platform.appdata.basedir=/worldline/sesame/data/aduna"
ENV CATALINA_HOME /opt/apache-tomcat/tomcat7
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

#It has to be always up to date
#RUN apt-get -yqq update

#Add configuration
ADD aduna /worldline/sesame/data/aduna

#Add puppet modules
ADD modules /tmp/modules

#Adding the puppet manifest and executing it.
ADD Manifest.pp /tmp/Manifest.pp
RUN puppet apply --modulepath=/tmp/modules /tmp/Manifest.pp

EXPOSE 8080
CMD ["catalina.sh", "run"]
