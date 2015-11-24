$solr_HOME    	="/opt/solr/example/solr"
$solr_VERSION 	="4.10.4"
$solr         		="solr-${solr_VERSION}"
$ckan_VERSION	 ="2.2.3"
  
package { 'default-jre-headless':ensure => present,}
package { 'wget':ensure  => present,}
package { 'zip':ensure  => present,}

file {'/opt/solr': ensure => directory,}

file { '/opt/solr/example/solr/ckan':
          ensure => present,
          recurse=>true,
          source => "${solr_HOME}/collection1",
          require => Exec ['extract_solr']
}

file { '/opt/solr/example/solr/ckan/core.properties':
          content => "name=ckan",
          require => File ['/opt/solr/example/solr/ckan']
}

file { '/opt/solr/example/solr/ckan/conf/schema.xml':
          ensure => present,
          source => "/tmp/solr-master/schema.xml",
          require => Exec['extract_schema'],
}

exec { 'download_solr':
    command => "wget http://ftp-stud.hs-esslingen.de/pub/Mirrors/ftp.apache.org/dist/lucene/solr/${solr_VERSION}/${solr}.tgz",
    path    => '/usr/bin/:/bin/',
    require => Package['wget'],
}

 exec { 'extract_solr':
    command => "tar zxf ${solr}.tgz -C /opt/solr --strip-components 1",
    path    => '/usr/bin/:/bin/',
    require => File ['/opt/solr'],
} 

exec { 'download_schema':
    command => 'wget https://github.com/gcabezas/solr/archive/master.zip',
    path    => '/usr/bin/:/bin/',
    require => Package['wget'],
}

exec { 'extract_schema':
    command => 'unzip master.zip -d /tmp',
    path    => '/usr/bin/:/bin/',
    require => Package['zip'],
}
