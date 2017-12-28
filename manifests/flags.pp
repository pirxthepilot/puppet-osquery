# class osquery::flags - manage osqueryd flags in /etc/osquery/osquery.flags
class osquery::flags (

  $format = 'simple'

){
  include '::stdlib'

  file { $::osquery::flags_file:
    ensure  => present,
    content => template('osquery/osquery.flags.erb'),
    owner   => $::osquery::config_owner,
    group   => $::osquery::config_group,
    require => Package[$::osquery::package_name],
    notify  => Service[$::osquery::service_name],
  }

}
