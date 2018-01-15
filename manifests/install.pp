# == Class sqlgrey::install
#
# This class installs main package
# @param package_name OS dependent sqlgrey package name
# @param package_ensure ensure the state of sqlgrey software package
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
