# == Class: bhv_cms::sftp
#
# === Authors
#
# Author Name <foppe.pieters@naturalis.nl>
#
# === Copyright
#
# Apache2 license 2017.
#
class bhv_cms::sftp(
){

# setup sftp user
  user { $sftp_user:
    comment             => "sftp user",
    home                => "/home/${bhv_cms::sftp_user}",
    ensure              => present,
    managehome          => true,
    password            => sha1('${bhv_cms::sftp_user}'),
  }

  $image_name           = 'atmoz/sftp:latest'
  $container_name       = 'sftp'
  $diffcmd              = "/usr/bin/diff <(docker image inspect --format='{{.Id}}' ${image_name}) <(docker inspect --format='{{.Image}}' ${container_name})"
  $service_cmd          = "/usr/sbin/service docker-${container_name} restart"

  include 'docker'

  file { "/home/${bhv_cms::sftp_user}/${bhv_cms::sftp_dir}" :
     ensure             => directory,
     owner              => $bhv_cms::sftp_user,
     group              => $bhv_cms::sftp_user,
     mode               => '0777'
   }

  docker::run { $container_name :
    image               => $image_name,
    ports               => ["${bhv_cms::sftp_port}:22"],
    command             => "${bhv_cms::sftp_user}:${bhv_cms::sftp_pass}"
    volumes             => ["${bhv_cms::php_dir}/${bhv_cms::sftp_dir}:/home/${bhv_cms::sftp_user}/${bhv_cms::sftp_dir}"],
    require             => [User[$bhv_cms::sftp_user],File["/home/${bhv_cms::sftp_user}/${bhv_cms::sftp_dir}"]]
  }

  exec { $service_cmd :
    unless              => $diffcmd,
    require             => [Exec["/usr/bin/docker pull ${image_name}"],Docker::Run[$container_name]]
  }

  exec {"/usr/bin/docker pull ${image_name}" :
    schedule            => 'everyday-sftp',
  }

  schedule { 'everyday-sftp':
    period              => daily,
    repeat              => 1,
    range               => '7-9',
  }

}
