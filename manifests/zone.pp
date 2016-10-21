define powerdns::zone () {
  concat::fragment { "powerdns-zone-headder-${name}":
    order   => "01_${name}",
    target  => "/etc/powerdns/${name}.zone",
    content => template('powerdns/zone-headder.erb'),
  }

  concat { "/etc/powerdns/${name}.zone":
    notify => Service['pdns']
  }

  concat::fragment { "powerdns-zone-include-${name}":
    order   => "01_${name}",
    target  => '/etc/powerdns/zone.include',
    content => template('powerdns/zone-include.erb'),
  }
}
