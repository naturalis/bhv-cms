# == Class: bhv-cms::sftp
#
# === Authors
#
# Author Name <foppe.pieters@naturalis.nl>
#
# === Copyright
#
# Apache2 license 2017.
#
class bhv-cms::sftp(
  $sftp_dir             = '/data/sftp',
  $sftp_port            = '2222',
  $sftp_login,
){

  $image_name='atmoz/sftp:latest'
  $container_name='sftp'
  $diffcmd = "/usr/bin/diff <(docker image inspect --format='{{.Id}}' ${image_name}) <(docker inspect --format='{{.Image}}' ${container_name})"
  $service_cmd = "/usr/sbin/service docker-${container_name} restart"

  include 'docker'

  file { $sftp_dir :
    ensure => directory,
  }

  docker::run { $container_name :
    image   => $image_name,
    ports   => ["${sftp_port}:22"],
    command => $sftp_login,
    volumes => ["${sftp_dir}:/tmp"],
    require => File[$sftp_dir]
  }

  exec { $service_cmd :
    unless  => $diffcmd,
    require => [Exec["/usr/bin/docker pull ${image_name}"],Docker::Run[$container_name]]
  }

  exec {"/usr/bin/docker pull ${image_name}" :
    schedule => 'everyday-sftp',
  }

  schedule { 'everyday-sftp':
    period => daily,
    repeat => 1,
    range  => '7-9',
  }

}
