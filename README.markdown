#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Overview

[![Build Status](https://travis-ci.org/spacedog/puppet-sqlgrey.svg?branch=master)](https://travis-ci.org/spacedog/puppet-sqlgrey)

This puppet module configures sqlgrey - postfix greylisting policy service with an SQL database as storage backend


## Usage

To configure sqlgrey module include it to puppet manifest and define _config_ hash with sqlgrey parameters

```puppet
class { '::sqlgrey:'
  config => {
    db_type => {
      value => 'mysql',
    },
    db_name => {
      value => 'sqlgrey',
    },
    db_user => {
      value => 'sqlgrey',
    },
    db_pass => {
      value => "DON'T SHARE SECRETS",
    },
    db_host => {
      value => 'localhost',
    },
    regect_code => {
      value => '451'
    },
  }
}
```

or the same but using using hiera

```puppet
include ::sqlgrey
```

```yaml
sqlgrey::config:
  db_type:
    value: 'mysql'
  db_name:
    value: 'sqlgrey'
  db_user:
    value: 'sqlgrey'
  db_pass:
    value: "DON'T SHARE SECRETS"
  db_host:
    value: 'localhost
  prepend:
    value: '1'
  optmethod:
    value: 'optout'
  reject_first_attempt:
    value: 'immed'
  reject_early_reconnect:
    value: 'immed'
  regect_code:
    value: '451'
  admin_mail:
    value: /dev/null
```


To define fqdn or ip whitelist use _clients_fqdn_whitelist_ or clients_ip_whitelist_ arrays:

```yaml
sqlgrey::clients_fqdn_whitelist:
  - 'test.example.com'
  - 'test1.example.com'
sqlgrey::clients_ip_whitelist:
  - '192.168.0.0/24'
  - '10.0.0.0/8'
```

## Reference

Check [./doc/index.html](https://github.com/spacedog/puppet-sqlgrey/doc/index.html)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.
 wv
## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 
