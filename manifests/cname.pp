define powerdns::cname (
  $target,
  $hostname = $name,
) {
  $zone = regsubst( $hostname , '^.+\.([A-z]+)$', '\1')
  $type = 'cname'
  concat::fragment { "powerdns-${zone}-${type}-${name}":
    order   => "02_${type}_${name}",
    target  => "/etc/powerdns/${zone}.zone",
    content => template('powerdns/zone-cname.erb'),
  }
}
