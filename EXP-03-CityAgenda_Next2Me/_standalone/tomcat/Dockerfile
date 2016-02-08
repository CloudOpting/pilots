FROM cloudopting/ubuntubase:14.04

MAINTAINER Xavier Cases Camats xavier.cases@worldline.com

#Environment variables
ENV JAVA_OPTS="-Xms512m -Xmx2g -XX:MaxPermSize=512m -Dsolr.solr.home=/worldline/tomcat-cloud4cities/data/solr -Dsolr.backoffice.server.properties=file:/worldline/tomcat-cloud4cities/cfg/application.properties -Dmongo.backoffice.server.properties=file:/worldline/tomcat-cloud4cities/cfg/application.properties -Dsolr.api.server.properties=file:/worldline/tomcat-cloud4cities/cfg/application.properties -Dmongo.api.server.properties=file:/worldline/tomcat-cloud4cities/cfg/application.properties"
ENV CATALINA_HOME /opt/apache-tomcat/tomcat7
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

#Add configuration files
ADD application.properties /worldline/tomcat-cloud4cities/cfg/application.properties
#ADD data /worldline/tomcat-cloud4cities/data

#Add puppet modules
ADD modules /tmp/modules

#Adding the puppet manifest and executing it.
ADD Manifest.pp /tmp/Manifest.pp
RUN puppet apply --modulepath=/tmp/modules /tmp/Manifest.pp

EXPOSE 8080

CMD ["catalina.sh", "run"]
