######################################################################
# @author Erika Heidi <erika@erikaheidi.com>
# @copyright 2014
#
# MAIN MANIFEST - SANDBOX PHP PUPPET PROVISION
######################################################################

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

$system_packages = ['vim', 'curl', 'git']
$php_packages = ['php5-cli', 'php5-curl', 'php-pear']

# first thing must be apt-get update
exec { 'apt-get update':
  command => 'apt-get update'
}

package { 'python-software-properties':
  ensure  => "installed",
  require => Exec['apt-get update']
}

exec { 'add-repository':
  command => "add-apt-repository ppa:ondrej/php5 -y",
  require => Package['python-software-properties'],
}

package { $system_packages:
  ensure => "installed",
  require => Exec['apt-get update'],
}

exec { 'apt-update-refresh':
  command => 'apt-get update',
  require => Exec['add-repository'],
  before  => Class['nginxphp']
}

class { 'nginxphp':
  doc_root => '/vagrant/web',
  php_packages => $php_packages,
}

/********************************************************
 If you want to use Apache, uncomment below (and comment
 the nginxphp declaration)
 You'll also have to change the dependencies on
 apt-update-refresh and composer declarations
********************************************************/
#class { 'apachephp':
#  doc_root => '/vagrant/web',
#  php_packages => $php_packages,
#}

class { 'composer':
  require => [ Package['curl'], Class['nginxphp'] ],
}

class { 'mysql':
  default_user => 'vagrantee',
  default_pass => 'vagrantee',
  default_db   => 'vagrantee',
  require => Exec['apt-get update'],
}