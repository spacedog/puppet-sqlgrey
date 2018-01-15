# == Class sqlgrey::service
#
# This class controlls sqlgrey service
# @param service_name OS dependent sqlgrey service name
# @param service_ensure state of sqlgrey service
# @param service_enable start sqlgrey during the OS boot
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
