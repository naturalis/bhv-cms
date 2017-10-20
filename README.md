bhv_cms
===================

Puppet module to run docker containers for Boerhaave cms system.

* CMS data is needed at /data/php on host system.

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
