# == Class: display::params
#
# Display parameters.
#
# === Authors
#
# Joshua Hoblitt <jhoblitt@cpan.org>
#
# === Copyright
#
# Copyright 2013 Joshua Hoblitt
#
class display::params {
  $lc_osfamily         = downcase($::osfamily)
  $x11vnc_package_name = 'x11vnc'
  $x11vnc_service_name = 'x11vnc'
  $xvfb_erb            = "display/${lc_osfamily}/xvfb.erb"
  $x11vnc_erb          = "display/${lc_osfamily}/x11vnc.erb"
  $xvfb_service_name   = 'xvfb'
  $display             = 0
  $width               = 1280
  $height              = 800
  $color               = '24+32'
  $runuser             = 'root'
  $fbdir               = '/tmp'

  case $::osfamily {
    'redhat': {
      $xvfb_package_name = 'xorg-x11-server-Xvfb'
      $x11vnc_bin        = '/usr/bin/x11vnc'
      $init_path         = '/etc/init.d'
    }
    'debian': {
      $xvfb_package_name = 'xvfb'
      $x11vnc_bin        = '/usr/bin/x11vnc'
      $init_path         = '/etc/init.d'
    }
    'freebsd': {
      $xvfb_package_name = 'xorg-vfbserver'
      $x11vnc_bin        = '/usr/local/bin/x11vnc'
      $init_path         = '/usr/local/etc/rc.d'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
