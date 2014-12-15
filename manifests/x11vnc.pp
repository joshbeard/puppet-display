# == Class: display::x11vnc
#
# Installs and configures x11vnc.
#
# === Parameters
#
# [*display*]
#   X display to use. Default is 0.
# [*x11vnc_bin*]
#   Absolute path to the 'x11vnc' executable. Defaults to '/usr/bin/x11vnc' on
#   RedHat and Debian systems and '/usr/local/bin/x11vnc' on FreeBSD.
# [*package*]
#   Package name for installing x11vnc. Defaults to 'x11vnc'
# [*service*]
#   Name of the x11vnc service.  This class will create an init script with the
#   name and manage a service by this name. Defaults to 'x11vnc'
# [*runuser*]
#   User to run xvfb as. Default is `'root'`
#
# === Authors
#
# Alex Rodionov <p0deje@gmail.com>
#
# === Copyright
#
# Copyright 2013 Alex Rodionov.
#
class display::x11vnc (
  $display    = $display::params::display,
  $x11vnc_bin = $display::params::x11vnc_bin,
  $package    = $display::params::x11vnc_package_name,
  $service    = $display::params::x11vnc_service_name,
  $runuser    = $display::params::runuser,
) inherits display::params {
  validate_re($display, '\d+')
  validate_absolute_path($x11vnc_bin)
  validate_string($package)
  validate_string($service)
  validate_string($runuser)

  package { 'x11vnc':
    ensure => present,
    name   => $package,
  }

  file { 'x11vnc-init':
    ensure  => 'file',
    path    => "${display::params::init_path}/${service}",
    content => template($display::params::x11vnc_erb),
    mode    => '0755',
    require => Package['x11vnc'],
  }

  service { 'x11vnc':
    ensure    => running,
    name      => $service,
    enable    => true,
    subscribe => File['x11vnc-init'],
  }
}
