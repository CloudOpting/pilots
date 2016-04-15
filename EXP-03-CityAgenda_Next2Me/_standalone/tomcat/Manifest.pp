class { 'apt' : }

exec { 'apt-get update':
  command => '/usr/bin/apt-get update',
  before => Apt::Ppa["ppa:webupd8team/java"],
}

exec { 'apt-get common':
  command => '/usr/bin/apt-get -yqq install software-properties-common python-software-properties',
  before => Apt::Ppa["ppa:webupd8team/java"],
}

apt::ppa { "ppa:webupd8team/java": }

apt::key { 'ppa:webupd8team/java':
  id => '7B2C3B0889BF5709A105D03AC2518248EEA14886',
}

exec { 'apt-get update 2':
  command => '/usr/bin/apt-get update',
  require => Apt::Ppa["ppa:webupd8team/java"],
}

exec { "accept_license":
  command => "echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections",
  path => "/usr/bin/:/bin/",
  before => Package["oracle-java8-installer"],
  logoutput => true,
}

package { ["oracle-java8-installer"]: 
  ensure => present,
  require => Apt::Ppa["ppa:webupd8team/java"],
}

class { 'tomcat': 
  catalina_home => '/opt/apache-tomcat/tomcat7',
}

tomcat::instance { 'tomcat7':
  catalina_base => '/opt/apache-tomcat/tomcat7',
  catalina_home => '/opt/apache-tomcat/tomcat7',
  source_url    => 'https://raw.githubusercontent.com/CloudOpting/pilots/master/EXP-03-CityAgenda_Next2Me/_standalone/tomcat/apache-tomcat-7.0.68.tar.gz',
  install_from_source => true,
}->
tomcat::war { 'cloud4cities-webapp-api.war':
  catalina_base => '/opt/apache-tomcat/tomcat7',
  war_source => 'https://github.com/CloudOpting/pilots/blob/master/EXP-03-CityAgenda_Next2Me/_standalone/tomcat/cloud4cities-webapp-api.war?raw=true'
}->
tomcat::war { 'cloud4cities-webapp-solr.war':
  catalina_base => '/opt/apache-tomcat/tomcat7',
  war_source => 'https://github.com/CloudOpting/pilots/blob/master/EXP-03-CityAgenda_Next2Me/_standalone/tomcat/cloud4cities-webapp-solr.war?raw=true'
}->
tomcat::service { 'default':
  catalina_base => '/opt/apache-tomcat/tomcat7',
  service_ensure => 'stopped',
}
