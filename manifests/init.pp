# == Class: bhv_cms
#
# === Authors
#
# Author Name <foppe.pieters@naturalis.nl>
#
# === Copyright
#
# Apache2 license 2017.
#
class bhv_cms (
  $cms_dir              = '/data',
  $php_port             = '80',
  $php_dir              = '/data/php',
  $mysql_dir            = '/data/mysql',
  $mysql_pass,
  $phpmyadmin_port      = '8080',
  $php_image            = 'php:7.0-apache',
  $sftp_dir             = '/data/sftp',
  $sftp_port            = '2222',
  $sftp_user,
  $sftp_pass,
  $sftp_uid             = '1100',
){

  file { $cms_dir :
    ensure              => directory,
  }

  class { 'docker' :
    version             => 'latest',
  }

  class { 'bhv_cms::php' :
    require             => Class['docker']
  }

  class { 'bhv_cms::mysql' :
    require             => Class['docker']
  }

  class { 'bhv_cms::phpmyadmin':
    require             => Class['docker','bhv_cms::php','bhv_cms::mysql']
  }

  class { 'bhv_cms::sftp' :
    require             => Class['docker']
  }

}
