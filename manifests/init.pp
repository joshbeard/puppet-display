# == Class: display
#
# Installs and configures Xvfb and x11vnc.
#
# === Parameters
#
# [*display*]
#    X display to use. Default is 0.
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
# [*xvfb_package*]
#    Package name for installing xvfb. Defaults to 'xorg-x11-server-Xvfb' on
#    RedHat systems and 'xvfb' on Debian systems.
# [*xvfb_service*]
#    Name of the xvfb service. This class will create an initscript with this
#    name and manage a service with this name.  Defaults to 'xvfb'
# [*x11vnc_package*]
#    Package name for installing x11vnc. Defaults to 'x11vnc' on RedHat and
#    Debian systems.
# [*x11vnc_service*]
#    Name of the x11vnc service. This class will create an init script with
#    this name and manage a service with this name.  Defaults to 'x11vnc'
# [*x11vnc_bin*]
#    Absolute path to the 'x11vnc' executable. Defaults to '/usr/bin/x11vnc' on
#    RedHat and Debian systems and '/usr/local/bin/x11vnc' on FreeBSD.
#
# === Examples
#
#  class {'display':
#    display => 99,
#    width   => 1024,
#    height  => 768,
#    color   => 24,
#  }
#
# === Authors
#
# Alex Rodionov <p0deje@gmail.com>
#
# === Copyright
#
# Copyright 2013 Alex Rodionov.
#
class display (
  $display        = $display::params::display,
  $width          = $display::params::width,
  $height         = $display::params::height,
  $color          = $display::params::color,
  $runuser        = $display::params::runuser,
  $fbdir          = $display::params::fbdir,
  $xvfb_package   = $display::params::xvfb_package_name,
  $xvfb_service   = $display::params::xvfb_service_name,
  $x11vnc_package = $display::params::x11vnc_package_name,
  $x11vnc_service = $display::params::x11vnc_service_name,
  $x11vnc_bin     = $display::params::x11vnc_bin,
) inherits display::params {
  validate_re($display, '\d+')
  validate_re($width, '\d+')
  validate_re($height, '\d+')
  validate_re($color, '\d{2}\+\d{2}')
  validate_string($runuser)
  validate_absolute_path($fbdir)
  validate_string($xvfb_package)
  validate_string($xvfb_service)
  validate_string($x11vnc_package)
  validate_string($x11vnc_service)
  validate_absolute_path($x11vnc_bin)

  include env

  class { 'display::xvfb':
    display => $display,
    width   => $width,
    height  => $height,
    color   => $color,
    runuser => $runuser,
    fbdir   => $fbdir,
    package => $xvfb_package,
    service => $xvfb_service,
  }

  class { 'display::x11vnc':
    display    => $display,
    x11vnc_bin => $x11vnc_bin,
    package    => $x11vnc_package,
    service    => $x11vnc_service,
  }

  Class['xvfb'] -> Class['x11vnc'] -> Class['env']
}
