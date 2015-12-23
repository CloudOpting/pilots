node default {

class { 'tomcat': 
catalina_home => '/opt/apache-tomcat/tomcat8',}
class { 'java': 
distribution => 'jdk',}

tomcat::instance { '8.0.29':
catalina_base => 'root',
catalina_home => '/opt/apache-tomcat/tomcat8',
source_url => 'http://apache.mirror.iphh.net/tomcat/tomcat-8/v8.0.29/bin/apache-tomcat-8.0.29.tar.gz',
install_from_source => true,
}->
tomcat::config::server { '8.0.29':
  catalina_base => 'root',
  port => null,
}->
tomcat::service { 'default':
catalina_base => 'root',
service_ensure => 'stopped',
}



}