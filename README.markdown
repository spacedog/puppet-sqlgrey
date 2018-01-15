#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Reference - An under-the-hood peek at what the module is doing and how](#reference)

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
    value: 'localhost'
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

Check ./doc/index.html

## Limitations

Tested on Debian 6/7 and RedHat 5/6/7 with Puppet4 


