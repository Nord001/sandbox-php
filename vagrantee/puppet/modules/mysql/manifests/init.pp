# Class: mysql
#
# Main mysql manifest
#

class mysql(
$default_user = 'vagrantee',
$default_db   = 'vagrantee',
$default_pass = 'vagrantee'
) {

  package { ['mysql-server', 'mysql-client']:
    ensure  => 'installed'
  }

  service { 'mysql':
    ensure  => running,
    enable  => true,
    require => Package["mysql-server"],
  }

  exec { "set-mysql-root":
    unless  => "mysqladmin -uroot -p${default_pass} status",
    command => "mysqladmin -uroot password ${default_pass}",
    require => Service["mysql"],
  }

  exec { "create-${default_db}-db":
    unless => "/usr/bin/mysql -u${default_user} -p${default_pass} ${default_db}",
    command => "/usr/bin/mysql -uroot -p${default_pass} -e \"create user '${default_user}'@'localhost' identified by '${default_pass}'; create database ${default_db}; grant all on ${default_db}.* to ${default_user}@localhost;\"",
    require => Service["mysql"],
  }
}