# == Class: bhv_cms::phpmyadmin
#
# === Authors
#
# Author Name <foppe.pieters@naturalis.nl>
#
# === Copyright
#
# Apache2 license 2017.
#
class bhv_cms::phpmyadmin(
){

  $image_name           = 'phpmyadmin/phpmyadmin:latest'
  $container_name       = 'phpmyadmin'
  $diffcmd              = "/usr/bin/diff <(docker image inspect --format='{{.Id}}' ${image_name}) <(docker inspect --format='{{.Image}}' ${container_name})"
  $service_cmd          = "/usr/sbin/service docker-${container_name} restart"

  include 'docker'

  docker::run { $container_name :
    image               => $image_name,
    ports               => ["${bhv_cms::phpmyadmin_port}:80"],
    links               => ['mysql:db'],
    pull_on_start       => true
  }

  exec { $service_cmd :
    unless              => $diffcmd,
    require             => [Exec["/usr/bin/docker pull ${image_name}"],Docker::Run[$container_name]]
  }

  exec {"/usr/bin/docker pull ${image_name}" :
    schedule            => 'everyday-phpmyadmin',
  }

  schedule { 'everyday-phpmyadmin':
    period              => daily,
    repeat              => 1,
    range               => '7-9',
  }

}
