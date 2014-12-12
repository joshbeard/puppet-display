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
class display(
  $display      = $display::params::display,
  $width        = $display::params::width,
  $height       = $display::params::height,
  $color        = $display::params::color,
  $runuser      = $display::params::runuser,
  $fbdir        = $display::params::fbdir,
  $xvfb_package = $display::params::xvfb_package_name,
  $xvfb_service = $display::params::xvfb_service_name,
) inherits display::params {
  include env
  include x11vnc

  class { 'xvfb':
    display => $display,
    width   => $width,
    height  => $height,
    color   => $color,
    runuser => $runuser,
    fbdir   => $fbdir,
    package => $xvfb_package,
    service => $xvfb_service,
  }

  Class['xvfb'] -> Class['x11vnc'] -> Class['env']
}
