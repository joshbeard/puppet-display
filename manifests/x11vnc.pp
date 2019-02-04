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
# [*refresh_systemd*]
#   on systemd based systems a `systemctl daeomon-reload` is triggered before
#   the corresponding service ist started or restarted. 
# [*runuser*]
#   User to run xvfb as. Default is `'root'`
# [*custom_args*]
#    Specifies custom arguments to start x11vnc with.  This overrides the
#    display paramter - you'll have to pass that yourself.
#    String. Optional.  The default value is undefined (unused).
#
# === Authors
#
# Joshua Beard <beard@puppetlabs.com>
# Alex Rodionov <p0deje@gmail.com>
# Joshua Hoblitt <jhoblitt@cpan.org>
#
# === Copyright
#
# Copyright (C) 2013-2014 Joshua Beard <beard@puppetlabs.com>
# Copyright (C) 2013-2014 Alex Rodionov <p0deje@gmail.com>
# Copyright (C) 2012-2014 Joshua Hoblitt <jhoblitt@cpan.org>
#
class display::x11vnc (
  $display         = $display::params::display,
  $x11vnc_bin      = $display::params::x11vnc_bin,
  $package         = $display::params::x11vnc_package_name,
  $service         = $display::params::x11vnc_service_name,
  $refresh_systemd = $display::params::refresh_systemd,
  $runuser         = $display::params::runuser,
  $custom_args     = undef,
) inherits display::params {
  validate_integer($display)
  validate_absolute_path($x11vnc_bin)
  validate_string($package)
  validate_string($service)
  validate_string($runuser)

  if $custom_args {
    validate_string($custom_args)
  }

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

  if ($refresh_systemd) {
    exec { 'refresh_systemd x11vnc':
      subscribe   => File['x11vnc-init'],
      command     => 'systemctl daemon-reload',
      refreshonly => true,
      path        => $::path,
    }
    ~> Service['x11vnc']
  }

  service { 'x11vnc':
    ensure    => running,
    name      => $service,
    enable    => true,
    subscribe => File['x11vnc-init'],
  }
}
