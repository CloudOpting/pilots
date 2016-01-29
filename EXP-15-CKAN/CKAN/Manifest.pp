#GLOBAL VARIABLES FOR CKAN 
$imi_CKAN_site_id               ="default"
$imi_CKAN_site_url              ="ckan.cloudopting.eu"
$imi_CKAN_site_title            ="CloudOpting Open Data portal"
$imi_CKAN_site_description      ="A Public portal for openData basded on CKAN and deployed trough CloudOpting"
$db_name                        ="ckan"
$db_user                        ="ckan"
$db_pass                        ="ckan"

$cKAN_HOME                      ="/usr/lib/ckan/default"
$cKAN_CONFIG                    ="/etc/ckan/default"

#INSTALL PACKAGES
    exec { 'apt-get update':  path => '/usr/bin',}->
    
    package { 'python-minimal':     ensure => 'present', }->
    package { 'python-dev':         ensure => 'present', }->
    package { 'python-virtualenv':  ensure => 'present', }->
    package { 'libevent-dev':       ensure => 'present', }->
    package { 'libpq-dev':          ensure => 'present', }->
    package { 'nginx-light':        ensure => 'present', }->
    package { 'apache2':            ensure => 'present', }->
    package { 'libapache2-mod-wsgi':ensure => 'present', }->
    package { 'postfix':            ensure => 'present', }->
    package { 'build-essential':    ensure => 'present', }-> 
    package { 'wget':               ensure => 'present', }->
    package { 'git-core':           ensure => 'present', }-> 
   
# Install CKAN

file { '/etc/ckan':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
  }->
file { '/usr/lib/ckan':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
  }->
file { "${cKAN_HOME}":
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
  }->
file { "${cKAN_CONFIG}":
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
}->
#Download and Install CKAN
exec { 'download_ckan':
    command => 'pip install -e git+https://github.com/ckan/ckan.git@ckan-2.5.1#egg=ckan',
    path    => '/usr/bin/:/bin/',
    cwd     => "${cKAN_HOME}",
    require => File["${cKAN_CONFIG}"],
}->
exec { 'install_requirements':
    command => 'pip install -r /usr/lib/ckan/default/src/ckan/requirements.txt',
    path    => '/usr/bin/:/bin/',
    cwd     => "${cKAN_HOME}",
    require => Exec['download_ckan'],
}->

exec {'create_file':
    command => 'paster make-config ckan /etc/ckan/default/production.ini',
    path    => '/usr/bin/:/bin/:/usr/local/bin/',
    cwd     => "${cKAN_CONFIG}",    
    require => Exec['install_requirements'],
}
#CKAN CONFIG FILE CREATION
file { '/etc/ckan/default/production.ini':
  ensure  => 'file',
  content => template('/tmp/production.ini.erb'),
  require => Exec['create_file'],
}
exec { 'init_db':
    command => 'paster db init -c /etc/ckan/default/production.ini',
    path    => '/usr/bin/:/bin/:/usr/local/bin/',
    cwd     => '/usr/lib/ckan/default/src/ckan',
    require => File['/etc/ckan/default/production.ini'],
}
#Create Link
exec { 'link_to_who':
    command => 'ln -s /usr/lib/ckan/default/src/ckan/who.ini /etc/ckan/default/who.ini',
    path    => '/usr/local/bin/:/bin/',
    require => Exec['init_db'],
}
