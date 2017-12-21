# == Class sqlgrey::install
#
# This class installs main package
class sqlgrey::install (
  String  $package_name,
  Variant[
    Boolean,
    Enum['installed', 'latest']
  ]       $package_ensure,
) {

  package { $package_name:
    ensure => $package_ensure,
  }
}
