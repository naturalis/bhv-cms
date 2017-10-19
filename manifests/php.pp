# == Class: bhv-cms::php
#
# === Authors
#
# Author Name <foppe.pieters@naturalis.nl>
#
# === Copyright
#
# Apache2 license 2017.
#
class bhv-cms::php(
  $php_port             = '80',
  $cms_dir              = '/data/php'
){

  $image_name           = 'php:7.0-apache'
  $container_name       = 'php'
  $diffcmd              = "/usr/bin/diff <(docker image inspect --format='{{.Id}}' ${image_name}) <(docker inspect --format='{{.Image}}' ${container_name})"
  $service_cmd          = "/usr/sbin/service docker-${container_name} restart"

  include 'docker'

  file { $cms_dir :
    ensure              => directory
  }

  docker::run { $container_name :
    image               => $image_name,
    ports               => ["${php_port}:80"],
    volumes             => ["${cms_dir}:/var/www/html/upload"],
    require             => File[$cms_dir]
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
