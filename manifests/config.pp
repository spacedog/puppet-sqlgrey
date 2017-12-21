# == Class sqlgrey::config
#
# This class is called from sqlgrey for service config.
#
class sqlgrey::config (
  Boolean            $manage_db,
  Boolean            $db_export,
  Optional[String]   $db_tag,
  Hash[String, Data] $config,
  Optional[Array]    $clients_fqdn_whitelist,
  Optional[Array]    $clients_ip_whitelist,
) {
  include ::sqlgrey::params

  if has_key($config, 'db_type') {

    if !has_key($config, 'db_user') or !has_key($config, 'db_pass') or !has_key($config, 'db_host') {
      fail('db_user, db_type, db_name must be set!')
    }

    case $config['db_type']['value'] {
      'mysql': {
        if $manage_db {
          include ::mysql::server
        }


        ensure_packages(
          [
            $::sqlgrey::params::package_dbd_mysql,
          ]
        )

        if $db_export {
          @@mysql::db { "sqlgrey_${::fqdn}":
            user     => $config['db_user']['value'],
            password => $config['db_pass']['value'],
            dbname   => $config['db_name']['value'],
            host     => $::ipaddress,
            tag      => $db_tag,
          }
        } else {
          $db_host = has_key($config, 'db_host') ? {
            true    => $config['db_host']['value'],
            default => $::ipaddress,
          }

          mysql::db { 'sqlgrey':
            ensure   => present,
            user     => $config['db_user']['value'],
            password => $config['db_pass']['value'],
            dbname   => $config['db_name']['value'],
            host     => $db_host,
          }
        }
      }
      default: {
        fail("${config['db_type']['value']} db type is not supported yet")
      }
    }

  }


  file { '/etc/sqlgrey/clients_fqdn_whitelist.local':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => join(sort($clients_fqdn_whitelist), "\n"),
  }

  file { '/etc/sqlgrey/clients_ip_whitelist.local':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => join(sort($clients_ip_whitelist),"\n"),
  }

  $config.each |String $resource, Hash $options| {
    ::sqlgrey::config::param { $resource:
      * => $options,
    }
  }

}

