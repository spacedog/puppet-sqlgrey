# == Class sqlgrey::service
#
# This class controlls sqlgrey service
class sqlgrey::service (
  String             $service_name,
  Variant[
    Boolean,
    Enum['running', 'stopped']
  ]                  $service_ensure,
  Boolean            $service_enable,
){

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }
}
