# Puppet related recommendations

## About modules and manifests

[Puppet Modules and Manifests](https://docs.puppetlabs.com/pe/latest/puppet_modules_manifests.html)

## Puppetfile: describe modules

The __puppetfile__ is the file where describe which puppet modules are going to be available in the context.

The context is common for all the images in a service.

This is the official __puppetfile__ documentation: https://github.com/puppetlabs/r10k/blob/master/doc/puppetfile.mkd

It is recommended to specify package version for the modules.

Remember to add also the dependences of each module.

This is an example:

```ruby
forge "https://forgeapi.puppetlabs.com"

mod 'puppetlabs-apt',
  :git => "git://github.com/puppetlabs/puppetlabs-apt.git",
  :ref => "2.1.1"

mod 'puppetlabs-stdlib',
  :git => "https://github.com/puppetlabs/puppetlabs-stdlib",
  :ref => "4.9.0"

mod 'puppetlabs-concat',
  :git => "https://github.com/puppetlabs/puppetlabs-concat",
  :ref => "1.2.4"

mod 'puppet-python',
  :git => "https://github.com/stankevich/puppet-python",
  :ref => "1.9.8"

mod 'puppetlabs-vcsrepo',
  :git => "https://github.com/puppetlabs/puppetlabs-vcsrepo",
  :ref => "1.3.1"
```

## Puppet manifests

This is the file that describes the actions to apply in a system (a container in our case).

[Here](https://docs.puppetlabs.com/puppet/3.8/reference/lang_visual_index.html) it is the offcial language documentation.

Maybe it's more practical to start from examples and look at the specific module documentation.

This is an example for installing a python application from a github repo:

```puppet
# Clone repo
vcsrepo { '/usr/src/app':
  ensure   => present,
  provider => git,
  source   => 'git://github.com/wtelecom/crane-tests-webconsumer.git',
}

# Install requirements
class { 'python' :
  version    => 'system',
  pip        => 'present',
  dev        => 'present',
}

exec { "requirements":
    command => "pip install -r requirements.txt",
    cwd     => "/usr/src/app",
    path    => "/usr/local/bin/:/bin/:/usr/bin",
    require => Class["python"]
}
```

### Advices

#### Do not launch services in the manifest

Avoid to use directives that start the services (like `ensure => 'running'`).

Manifests are applied in building time, not execution time.

The 'start command' has to be written in the Dockerfile ([_CMD_](http://docs.docker.com/engine/reference/builder/#cmd)) or in [the _docker-compose_ file with _command_](http://docs.docker.com/compose/compose-file/#command).

#### Assure that the manifest has everything to work

The base images we are using are really skinny, you need to install everything you want to use.

For example:
- If you want to install a package from _apt-get_, you need first to make an _apt-get update_ because the cache is empty.
- If you want to clone a repo, you need to install the git tool.
- If you want to un-zip something, check that _unzip_ is installed.
