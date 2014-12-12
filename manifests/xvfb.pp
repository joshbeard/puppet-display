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
  $runuser = 'root',
  $fbdir   = '/tmp',
  $package = $display::params::xvfb_package_name,
  $service = $display::params::xvfb_service_name,
) inherits display::params {
  package { 'xvfb':
    ensure => present,
    name   => $package,
    alias  => 'xvfb',
  }

  file { "/etc/init.d/${service}":
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
