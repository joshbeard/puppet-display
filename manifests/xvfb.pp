# == Class: display::xvfb
#
# Installs and configures xvfb.
# Inspired by https://github.com/cwarden/puppet-module-xvfb.
#
# === Parameters
#
# [*display*]
#   X display to use. Default is 0.
# [*width*]
#    Screen width to use. Default is 1280.
# [*height*]
#    Screen height to use. Default is 800.
# [*color*]
#    Screen color depth to use. Default is "24+32" (32 bit).
# [*runuser*]
#    User to run xvfb as. Default is 'root'.
# [*fbdir*]
#    Directory in which the memory mapped files containing the framebuffer
#    memory should be created. Defaults to '/tmp'
# [*package*]
#    Package name for installing xvfb. Defaults to 'xorg-x11-server-Xvfb' on
#    RedHat systems and 'xvfb' on Debian systems.
# [*service*]
#    Name of the xvfb service. This class will create an initscript with this
#    name and manage a service with this name.  Defaults to 'xvfb'
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
class display::xvfb (
  $display  = $display::params::display,
  $width    = $display::params::width,
  $height   = $display::params::height,
  $color    = $display::params::color,
  $runuser  = $display::params::runuser,
  $fbdir    = $display::params::fbdir,
  $package  = $display::params::xvfb_package_name,
  $service  = $display::params::xvfb_service_name,
  $xvfb_bin = $display::params::xvfb_bin,
) inherits display::params {
  validate_re($display, '\d+')
  validate_re($width, '\d+')
  validate_re($height, '\d+')
  validate_re($color, '\d{2}\+\d{2}')
  validate_string($runuser)
  validate_absolute_path($fbdir)
  validate_string($package)
  validate_string($service)
  validate_absolute_path($xvfb_bin)

  package { 'xvfb':
    ensure => present,
    name   => $package,
  }

  file { 'xvfb-init':
    ensure  => 'file',
    path    => "${display::params::init_path}/${service}",
    content => template($display::params::xvfb_erb),
    mode    => '0755',
    require => Package['xvfb'],
  }

  service { 'xvfb':
    ensure    => running,
    name      => $service,
    enable    => true,
    subscribe => File['xvfb-init'],
  }
}
