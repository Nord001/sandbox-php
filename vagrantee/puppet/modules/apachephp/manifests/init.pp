# Class: apachephp
#
# Main apachephp manifest
#

class apachephp(
  $doc_root = '/vagrant',
  $php_packages = ['php5-curl', 'php5-cli', 'php-pear', 'php5-mysql']
) {

  package { ['apache2', 'php5']:
    ensure  => 'installed'
  }

  service { 'apache2':
    ensure     => running,
    enable     => true,
  }

  file { "/etc/apache2/sites-available/000-default.conf":
    ensure  => 'present',
    content => template("apachephp/apache/vhost.conf.erb"),
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  package { $php_packages:
    ensure => "installed"
  }

}