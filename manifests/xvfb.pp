# == Class: display::xvfb
#
# Installs and configures xvfb.
# Inspired by https://github.com/cwarden/puppet-module-xvfb.
#
# === Authors
#
# Alex Rodionov <p0deje@gmail.com>
#
# === Copyright
#
# Copyright 2013 Alex Rodionov.
#
class display::xvfb (
  $display = 0,
  $width   = 1280,
  $height  = 768,
  $color   = '24+32',
  $package = $display::params::xvfb_package_name,
  $service = $display::params::xvfb_service_name,
) inherits display::params {
  package { 'xvfb':
    ensure => present,
    name   => $package,
    alias  => 'xvfb',
  }

  file { '/etc/init.d/xvfb':
    ensure  => 'file',
    content => template($display::params::xvfb_erb),
    mode    => '0755',
    require => Package['xvfb'],
    notify  => Service['xvfb'],
  }

  service { 'xvfb':
    ensure     => running,
    name       => $service,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
