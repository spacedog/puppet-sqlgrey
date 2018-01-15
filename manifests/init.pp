# == Class: sqlgrey
#
# Main init class for sqlgrey
#
# @param package_name OS dependent sqlgrey package name
# @param service_name OS dependent sqlgrey service name
# @param service_ensure state of sqlgrey service
# @param service_enable start sqlgrey during the OS boot
# @param package_ensure ensure the state of sqlgrey software package
# @param config sqlgrey configuration options
# @param manage_db manage db setup with that module
# @param db_export export db to puppet collectors
# @param db_tag export tag for puppet collectors
# @param clients_fqdn_whitelist the list of whitelisted FQDNs
# @param clients_ip_whitelist the list of whitelisted IPs
class sqlgrey (
  String             $package_name           = $::sqlgrey::params::package_name,
  String             $service_name           = $::sqlgrey::params::service_name,
  Variant[
    Boolean,
    Enum['running', 'stopped']
  ]                  $service_ensure         = 'running',
  Boolean            $service_enable         = true,
  Variant[
    Boolean,
    Enum['installed', 'latest']
  ]                  $package_ensure         = 'installed',
  Hash[String, Data] $config                 = {},
  Boolean            $manage_db              = false,
  Boolean            $db_export              = false,
  Optional[String]   $db_tag                 = undef,
  Optional[Array]    $clients_fqdn_whitelist = [],
  Optional[Array]    $clients_ip_whitelist   = [],

) inherits ::sqlgrey::params {

  class { '::sqlgrey::install':
    package_name   => $package_name,
    package_ensure => $package_ensure,
  }
  -> class { '::sqlgrey::config':
    config                 => $config,
    manage_db              => $manage_db,
    db_tag                 => $db_tag,
    db_export              => $db_export,
    clients_ip_whitelist   => $clients_ip_whitelist,
    clients_fqdn_whitelist => $clients_fqdn_whitelist,
  }
  ~> class { '::sqlgrey::service':
    service_name   => $service_name,
    service_ensure => $service_ensure,
    service_enable => $service_enable,
  }
  -> Class['::sqlgrey']
}
