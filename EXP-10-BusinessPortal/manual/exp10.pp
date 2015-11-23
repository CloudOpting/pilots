#install apache
#include apache

class exp10{
        
        class { 'apache':
		docroot => '/var/www',
	}
	#install mpm_prefork required by php
	class {apache:mpm_module => 'prefork'}

	#install php
	class {'apache::mod::php': }

	# Copy to /var/www/
	exec { 'copy':
		command => "cp -r /tmp/wordpress.tar.gz/wordpress/* /var/www/",
		path => ['/bin'],
	}

	# Generate the wp-config.php file using the template
	file { '/var/www/wp-config.php':
		ensure => present,
		require => Exec['copy'],
		content => template("/tmp/wp-config.php.erb")
	}

	class { '::mysql::server':
		root_password           => 'strongpassword',
		remove_default_accounts => true
	}
}