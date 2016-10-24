powerdns
========

This module install powerdns and recursor on one machine and manage its record via resources and exported resources


## Usage

# server instalation class

```
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
