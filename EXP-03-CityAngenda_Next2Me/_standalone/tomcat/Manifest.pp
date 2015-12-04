class { 'tomcat': }
class { 'java': }

tomcat::instance { 'tomcat8':
  catalina_base => '/opt/apache-tomcat/tomcat8',
  source_url    => 'http://apache.mirror.iphh.net/tomcat/tomcat-8/v8.0.29/bin/apache-tomcat-8.0.29.tar.gz'
}->
tomcat::setenv::entry {'JAVA_OPTS':
    value => "-Xms512m -Xmx2g -XX:MaxPermSize=512m -Dsolr.solr.home=/worldline/tomcat-cloud4cities/data/solr -Dsolr.backoffice.server.properties=file:/worldline/tomcat-cloud4cities/cfg/application.properties -Dmongo.backoffice.server.properties=file:/worldline/tomcat-cloud4cities/cfg/application.properties -Dsolr.api.server.properties=file:/worldline/tomcat-cloud4cities/cfg/application.properties -Dmongo.api.server.properties=file:/worldline/tomcat-cloud4cities/cfg/application.properties",
}->
tomcat::service { 'default':
  catalina_base => '/opt/apache-tomcat/tomcat8'
}->
tomcat::war { 'cloud4cities-webapp-api.war':
  catalina_base => '/opt/apache-tomcat/tomcat8',
  war_source => 'https://github.com/CloudOpting/pilots/blob/master/EXP-03-CityAngenda_Next2Me/_standalone/tomcat/cloud4cities-webapp-api.war'
}->
tomcat::war { 'cloud4cities-webapp-solr.war':
  catalina_base => '/opt/apache-tomcat/tomcat8',
  war_source => 'https://github.com/CloudOpting/pilots/blob/master/EXP-03-CityAngenda_Next2Me/_standalone/tomcat/cloud4cities-webapp-solr.war'
}
