# == Class: bhv_cms::php
#
# === Authors
#
# Author Name <foppe.pieters@naturalis.nl>
#
# === Copyright
#
# Apache2 license 2017.
#
class bhv_cms::php(
){

  $image_name           = 'php:7.0-apache'
  $container_name       = 'php'
  $diffcmd              = "/usr/bin/diff <(docker image inspect --format='{{.Id}}' ${image_name}) <(docker inspect --format='{{.Image}}' ${container_name})"
  $service_cmd          = "/usr/sbin/service docker-${container_name} restart"

  include 'docker'

  file { $bhv_cms::php_dir :
    ensure              => directory,
    group               => '100'
  }

  docker::run { $container_name :
    image               => $image_name,
    ports               => ["${bhv_cms::php_port}:80"],
    volumes             => ["${bhv_cms::php_dir}:/var/www/html","${bhv_cms::sftp_dir}:/var/www/html/upload"],
    require             => File[$bhv_cms::php_dir]
  }

  exec { $service_cmd :
    unless              => $diffcmd,
    require             => [Exec["/usr/bin/docker pull ${image_name}"],Docker::Run[$container_name]]
  }

  exec {"/usr/bin/docker pull ${image_name}" :
    schedule            => 'everyday-php',
  }

  schedule { 'everyday-php':
    period              => daily,
    repeat              => 1,
    range               => '7-9',
  }

}
