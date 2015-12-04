class { 'tomcat': }
class { 'java': }

tomcat::instance { 'tomcat8':
  catalina_base => '/opt/apache-tomcat/tomcat8',
  source_url    => 'http://apache.mirror.iphh.net/tomcat/tomcat-8/v8.0.29/bin/apache-tomcat-8.0.29.tar.gz'
}->
tomcat::setenv::entry {'JAVA_OPTS':
    value => "-Xms512m -Xmx2g -Dinfo.aduna.platform.appdata.basedir=/worldline/tomcat-sesame-cloud4cities/data/aduna",
}->
tomcat::service { 'default':
  catalina_base => '/opt/apache-tomcat/tomcat8',
}->
tomcat::war { 'openrdf-sesame.war':
  catalina_base => '/opt/apache-tomcat/tomcat8',
  war_source => 'https://github.com/CloudOpting/pilots/blob/master/EXP-03-CityAngenda_Next2Me/_standalone/sesame/openrdf-sesame.war',
}->
tomcat::war { 'openrdf-workbench.war':
  catalina_base => '/opt/apache-tomcat/tomcat8',
  war_source => 'https://github.com/CloudOpting/pilots/blob/master/EXP-03-CityAngenda_Next2Me/_standalone/sesame/openrdf-workbench.war',
}
