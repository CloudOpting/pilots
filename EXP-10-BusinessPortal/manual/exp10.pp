  class { 'apache':                # use the "apache" module
    default_vhost => false,        # don't use the default vhost
    default_mods => false,         # don't load default mods
    mpm_module => 'prefork',        # use the "prefork" mpm_module
  }
   include apache::mod::php        # include mod php
   apache::vhost { 'example.com':  # create a vhost called "example.com"
    port    => '80',               # use port 80
    docroot => '/var/www/html',     # set the docroot to the /var/www/html
  }
#class { 'mysql::server': 
#	root_password => 'strongpassword',
#	remove_default_accounts => true ,
#}

#class { 'mysql::bindings':
#	php_enable => true,
#}

# Copy to /var/www/html
exec { 'copy':
	command => "cp -r /tmp/wordpress.tar.gz/wordpress/* /var/www/html/",
	require => Class ['apache'],
	path => ['/bin'],
}

# Generate the wp-config.php file using the template
file { '/var/www/html/wp-config.php':
	ensure => present,
	require => Exec['copy'],
	source => '/tmp/wp-config.php.erb',
}
