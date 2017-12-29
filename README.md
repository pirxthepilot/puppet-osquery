[![Build Status](https://travis-ci.org/BIAndrews/puppet-osquery.svg)](https://travis-ci.org/BIAndrews/puppet-osquery)

# OSQuery

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with osquery](#setup)
    * [What osquery affects](#what-osquery-affects)
    * [Setup requirements](#setup-requirements)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

OSQuery installation and configuration Puppet module.

## Setup

### What OSQuery affects

* osquery repo installed by default, can be disabled.
* osquery package installed.
* osquery JSON config file setup.
* osquery service ran.

### Setup Requirements

Uses apt module for Ubuntu to setup the repository or yum if Redhat family to install the repo RPM.

## Usage

Basic usage example with defaults.

~~~
include osquery
~~~

Usage example including some custom settings.

~~~
class { 'osquery':
  settings => {
    'options' => {
      'event_pubsub_expiry' => '86000',
      'debug' => false,
      'worker_threads' => $::processorcount,
    },
    'schedule' => {
      'info' => {
        'query' => 'SELECT * FROM osquery_info',
        'interval' => '3600',
      },
    },
  }
}
~~~

### osqueryd flags

The osqueryd startup flags can be configured via `osquery::flags`. Example:

~~~
class { 'osquery':
  flags => {
    'enroll_secret_path'             => '/var/osquery/enroll_secret',
    'tls_server_certs'               => '/var/osquery/server.pem',
    'tls_hostname'                   => '192.168.1.100:8080',
    'host_identifier'                => 'uuid',
    'enroll_tls_endpoint'            => '/api/v1/osquery/enroll',
    'config_plugin'                  => 'tls',
    'config_tls_endpoint'            => '/api/v1/osquery/config',
    'config_tls_refresh'             => '10',
    'disable_distributed'            => 'false',
    'distributed_plugin'             => 'tls',
    'distributed_interval'           => '3',
    'distributed_tls_max_attempts'   => '3',
    'distributed_tls_read_endpoint'  => '/api/v1/osquery/distributed/read',
    'distributed_tls_write_endpoint' => '/api/v1/osquery/distributed/write',
    'logger_plugin'                  => 'tls',
    'logger_tls_endpoint'            => '/api/v1/osquery/log',
    'logger_tls_period'              => '10',
  }
}
~~~

## Reference

* `osquery::settings` - hash converted into a JSON string for the OSQuery config file. Default is based on upstream package example config.
* `osquery::flags` - hash converted into osqueryd arguments in /etc/osquery/osquery.flags. Defaults to an empty hash.
* `osquery::package_name` - Package name to install. Default is auto detect based on OSFamily.
* `osquery::service_name` - Service name to run. Default is auto detect based on OSFamily.
* `osquery::package_ver` - latest or present. Defaults to latest.
* `osquery::params::config` - Full path to config file. Defaults to /etc/osquery/osquery.conf.
* `osquery::params::repo_install` - Boolan, manage the repo or not. Default is true.
* `osquery::params::repo_url` - Repo URL.
* `osquery::params::repo_name` - Redhat repo RPM name.
* `osquery::params::repo_key_id` - Apt repo signature key ID.
* `osquery::params::repo_key_server` - Apt repo key server.

## Limitations

OSQuery is developed for CentOS6/7 as well as Ubuntu Trusty 14.04 LTS and Precise 12.04 LTS only. 
