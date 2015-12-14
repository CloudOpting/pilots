#Module to be installed:
#
#puppet module install puppetlabs-postgresql
#

class { 'postgresql::globals':
    encoding => 'UTF8',
    manage_package_repo => true,
    postgis_version     => '2.1',
    version => '9.3',
    require => Exec['change_locale'],
  }
class { 'postgresql::server':
    ip_mask_deny_postgres_user => '0.0.0.0/32',
    ip_mask_allow_all_users    => '0.0.0.0/0',
    listen_addresses           => '*',
    postgres_password          => 'postgresql',
    ipv4acls                   => ['host all all 127.0.0.1/32 trust'],
   require => Exec['change_locale'],
}
postgresql::server::db { 'ckan':
  user        => 'CO_USER',
  password    => postgresql_password('ckan', 'ckan'),
  owner       =>'ckan',
  require => Exec['change_locale'],
}
postgresql::server::role { 'ckan':
  password_hash => postgresql_password('ckan', 'ckan'),
  require => Exec['change_locale'],
}
exec { 'change_locale':
    command => 'locale-gen en_US en_US.UTF-8',
    path    => '/usr/sbin/:/bin/',
}
