# == Class: bhv-cms::mysql
#
# === Authors
#
# Author Name <foppe.pieters@naturalis.nl>
#
# === Copyright
#
# Apache2 license 2017.
#
class bhv-cms::mysql(
  $mysql_dir            = '/data/mysql',
  $mysql_pass,
){

  $image_name           = 'mysql:8'
  $container_name       = 'mysql'
  $diffcmd              = "/usr/bin/diff <(docker image inspect --format='{{.Id}}' ${image_name}) <(docker inspect --format='{{.Image}}' ${container_name})"
  $service_cmd          = "/usr/sbin/service docker-${container_name} restart"

  include 'docker'

  file { $mysql_dir :
    ensure => directory,
  }

  docker::run { $container_name :
    image               => $image_name,
    volumes             => ["${mysql_dir}:/var/lib/mysql","${mysql_dir}/conf.d:/etc/mysql/conf.d"],
    env                 => ["MYSQL_ROOT_PASSWORD=${mysql_pass}"],
    require             => File[$mysql_dir]
  }

  exec { $service_cmd :
    unless              => $diffcmd,
    require             => [Exec["/usr/bin/docker pull ${image_name}"],Docker::Run[$container_name]]
  }

  exec {"/usr/bin/docker pull ${image_name}" :
    schedule            => 'everyday-mysql',
  }

  schedule { 'everyday-mysql':
    period              => daily,
    repeat              => 1,
    range               => '7-9',
  }

}
