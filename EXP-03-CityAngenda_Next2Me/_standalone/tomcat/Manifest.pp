class { 'tomcat': }
class { 'java': }

tomcat::instance { 'tomcat8':
  catalina_base => '/opt/apache-tomcat/tomcat8',
  source_url    => 'http://apache.mirror.iphh.net/tomcat/tomcat-8/v8.0.29/bin/apache-tomcat-8.0.29.tar.gz'
}->
tomcat::service { 'default':
  catalina_base => '/opt/apache-tomcat/tomcat8'
}
tomcat::war { 'cloud4cities-webapp-api.war':
  catalina_base => '/opt/apache-tomcat/tomcat8',
  war_source => '/tmp/cloud4cities-webapp-api.war'
}
tomcat::war { 'cloud4cities-webapp-solr.war':
  catalina_base => '/opt/apache-tomcat/tomcat8',
  war_source => '/tmp/cloud4cities-webapp-solr.war'
}
