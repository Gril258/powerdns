define powerdns::raw (
  $value,
  $zone,
) {
  $type = 'raw'
  concat::fragment { "powerdns-${zone}-raw-${name}":
    order   => "02_${type}",
    target  => "/etc/powerdns/${zone}.zone",
    content => template('powerdns/zone-raw.erb'),
  }
}
