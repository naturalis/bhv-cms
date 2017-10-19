# == Class: bhv-cms
#
# === Authors
#
# Author Name <foppe.pieters@naturalis.nl>
#
# === Copyright
#
# Apache2 license 2017.
#
class bhv-cms (
  $mysql_pass           = $bhv-cms::params::mysql_pass,
  $sftp_login           = $bhv-cms::params::sftp_login,
) inherits bhv-cms::params {

  class { '::bhv-cms::php'}
  class { '::bhv-cms::mysql':
    mysql_pass          => $mysql_pass,
  }
  class { '::bhv-cms::phpmyadmin'}
  class { '::bhv-cms::sftp':
    sfpt_login          => $sftp_login,
  }
}
