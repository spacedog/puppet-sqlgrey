# == Class sqlgrey::params
#
# This class is meant to be called from sqlgrey.
# It sets variables according to platform.
#
class sqlgrey::params {
  case $::osfamily {
    'Debian': {
      $package_name      = 'sqlgrey'
      $service_name      = 'sqlgrey'
      $package_dbd_mysql = 'perl-DBD-MySQL'
    }
    'RedHat', 'Amazon': {
      $package_name      = 'sqlgrey'
      $service_name      = 'sqlgrey'
      $package_dbd_mysql = 'perl-DBD-MySQL'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
