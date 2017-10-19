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
){
  contain '::bhv-cms::php'
  contain '::bhv-cms::mysql'
  contain '::bhv-cms::phpmyadmin'
  contain '::bhv-cms::sftp'
}
