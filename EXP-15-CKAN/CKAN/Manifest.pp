#GLOBAL VARIABLES FOR CKAN 

$imi_CKAN_site_id               ="default"
$imi_CKAN_site_url              ="ckan.cloudopting.eu"
$imi_CKAN_site_title            ="CloudOpting Open Data portal"
$imi_CKAN_site_description      ="A Public portal for openData basded on CKAN and deployed trough CloudOpting"
$sqlalchemy                     ="postgresql://ckan:ckan@172.17.0.3:5432/ckan"
$solr_url                       ="http://172.17.0.2:8983/solr/ckan"
$db_name                        ="ckan"
$db_user                        ="ckan"
$db_pass                        ="ckan"







#INSTALL CKAN
#INSTALL PACKAGES
    exec { 'apt-get update':  path => '/usr/bin',}->
    package { 'nginx':              ensure => 'present', }->
    package { 'apache2':            ensure => 'present', }->
    package { 'libapache2-mod-wsgi':ensure => 'present', }->
    package { 'libpq5':             ensure => 'present', }->
    package { 'wget':               ensure => 'present', }->
    package { 'dpkg':               ensure => 'present', }->

#DOWNLOAD AND INSTALL CKAN

exec { 'download_ckan':
  command => 'wget http://packaging.ckan.org/python-ckan_2.4-trusty_amd64.deb',
  path    => '/usr/bin/:/bin/',
  require => Package['wget'],
}

exec { 'install_ckan_source':
  command => 'dpkg -i python-ckan_2.4-trusty_amd64.deb',
  path    => '/usr/bin/:/bin/:/usr/bin/dpkg/',
  require => Exec['download_ckan'],
}
package { 'install_ckan_source':
  provider => 'dpkg',
  source   =>"/python-ckan_2.4-trusty_amd64.deb",
  require => Exec['download_ckan'],
}
#CKAN CONFIG FILE CREATION
  file { '/etc/ckan/default/production.ini':
  ensure  => 'file',
  content => template('/tmp/production.ini.erb'),
  require => Package'install_ckan_source'],
}
