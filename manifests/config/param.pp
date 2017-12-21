# == Define: sqlgrey::config::param
#
# This defined type manages sqlgrey configuration parameters
define sqlgrey::config::param (
  String $value,
  String $key   = $name,
) {

  if $key =~ /db_pass/ {
    $_show_diff = false
  } else {
    $_show_diff = true
  }
  augeas { "sqlgrey-param-${name}":
    changes   => "set /files/etc/sqlgrey/sqlgrey.conf/${key} ${value}",
    lens      => 'Simplevars.lns',
    incl      => '/etc/sqlgrey/sqlgrey.conf',
    show_diff => $_show_diff,
  }

}
