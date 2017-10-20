bhv_cms
===================

Puppet module to run docker containers for Boerhaave cms system.

* This module builds 4 separate docker containers.
  - mysql
  - PHP/Apache
  - PHPMyadmin
  - Sftp

* In the vm system different folders are mounted for each function:
  - /data/mysql/conf.d     = Mysql-container -> config
  - /data/mysql/db         = Mysql-container -> database
  - /data/php              = PHP/Apache-container (/var/www/html) -> web dir
  - /data/sftp             = Sftp-container (/home/foo/upload) & PHP/Apache-container (/var/www/html/upload) -> web dir

* 

Dependencies
-------------
- garethr/garethr-docker >= 5.3.0
- puppetlabs/stdlib

Puppet code
```
class { bhv_cms: }
```
Result
-------------
Separated docker containers for every function.

Limitations
-------------
This module has been built on and tested against Puppet 3.2

The module has been tested on:
- Ubuntu 16.04LTS
