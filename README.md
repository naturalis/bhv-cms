# bhv_cms

Puppet module to run docker containers for Boerhaave CMS system.

* This module builds 4 separate docker containers:
    - [mysql:8](https://hub.docker.com/_/mysql/)
    - [php:7.0-apache](https://hub.docker.com/_/php/)
    - [phpmyadmin/phpmyadmin:latest](https://hub.docker.com/r/phpmyadmin/phpmyadmin/)
    - [atmoz/sftp:latest](https://hub.docker.com/r/atmoz/sftp/)

* In the vm system different folders are mounted for each function:
    - /data/mysql/conf.d     = Mysql-container -> config
    - /data/mysql/db         = Mysql-container -> database
    - /data/php              = PHP/Apache-container (/var/www/html) -> web dir
    - /data/sftp             = Sftp-container (/home/boerhaave/content-clients) & PHP/Apache-container (/var/www/html/content-clients) -> web dir

## Dependencies
* We use the following dependencies:
    - [garethr/garethr-docker:5.3.0](https://github.com/garethr/garethr-docker/)
    - [puppetlabs/stdlib](https://github.com/puppetlabs/puppetlabs-stdlib)

Puppet code:

```
class { bhv_cms: }
```

## Result

Separated docker containers for every function.

## Limitations

This module has been built on and tested against Puppet 3.2 and 4.10

The module has been tested on:

* Ubuntu 16.04 LTS
