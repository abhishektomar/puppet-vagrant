# == Class: puppet::hiera
#
# This class manage hiera.yaml file

class puppet::hiera (
  $ensure       = $puppet::params::server_ensure,
  $package_name = $puppet::params::server_hiera_dep
  ) inherits puppet::params {

  file { '/etc/puppet/hiera.yaml' :
    ensure => present,
    owner => root,
    group => root,
    mode => 0644,
    before => Package[ 'puppetmaster' ],
    }

  package { "$package_name" :
    ensure => $ensure
  }
} 
