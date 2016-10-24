# Class: powerdns
#
#
class powerdns (
    $allow_from = '127.0.0.0/8, 10.0.0.0/8, 192.168.0.0/16,',
    $forward_zones = undef,
    $recursor_address = '127.0.0.1',
    $recursor_port = 53,
    $setgid = 'pdns',
    $setuid = 'pdns',
    $max_cache_ttl = undef,
    $forward_zones = undef,
    $server_address = $::ipaddress,
    $server_port = 10053,
    $rec_thread = 50,
    $dis_thread = 50,
    $backend = 'bind',
    $zone_list = { 'local' => {}, 'remote' => {}}
  ) {

  package { 'pdns-server':
    ensure => present,
  }

  package { 'pdns-recursor':
    ensure => present,
  }

  file { '/etc/powerdns/':
    ensure  => directory,
  }

  file { '/etc/powerdns/pdns.d/':
    ensure  => directory,
  }

  file { '/etc/powerdns/recursor.conf':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('powerdns/powerdns-recursor.conf.erb'),
    notify  => Service['pdns-recursor'],
  }

  file { '/etc/powerdns/pdns.conf':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('powerdns/powerdns-server.conf.erb'),
    notify  => Service['pdns'],
  }

  service { 'pdns-recursor':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    status     => '/usr/bin/rec_control ping | /bin/fgrep pong',
  }

  service { 'pdns':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  $zone_list = {
    'geo' => {},
    '10.in-addr.arpa' => {},
    'ipg' => {},
    'klasterka' => {},
    'dal' => {},
  }

  concat { '/etc/powerdns/zone.include':
    notify => Service['pdns']
  }

  create_resources(powerdns::zone, $zone_list)
  Powerdns::Raw <<| |>>
  Powerdns::Ptr <<| |>>
  Powerdns::Cname <<| |>>
  Powerdns::A <<| |>>
}
