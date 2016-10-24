powerdns
========

This module install powerdns and recursor on one machine and manage its record via resources and exported resources


## Usage

# server instalation class

```
  $forward_zones = 'local=127.0.0.1:10053, remote=10.0.0.36:10053' # if you need to forward zone to another dns
  class { 'powerdns':
    forward_zones    => $forward_zones,
    recursor_address => $::ipaddress,
    server_address   => $::ipaddress,
    max_cache_ttl    => 7200,
  }
```

# exported resource for records
```
  # A record
  @@powerdns::a { $::fqdn:
    ip => '10.20.30.40'
  }
  # PTR recors
  @@powerdns::ptr { $::fqdn:
    ip => '10.20.30.40'
  }
```
