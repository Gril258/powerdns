define powerdns::ptr (
  $ip = '172.16.23.42',
  $hostname = $name,
  $zone = '10.in-addr.arpa',
) {
  $type = 'ptr'
  concat::fragment { "powerdns-${zone}-${type}-${name}":
    order   => "02_${type}_${name}",
    target  => "/etc/powerdns/${zone}.zone",
    content => template('powerdns/zone-ptr.erb'),
  }
}
