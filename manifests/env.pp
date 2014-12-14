# == Class: display::env
#
# Exports DISPLAY variable.
#
# === Parameters
# [*file*]
#   Absolute path to place the environment file, which exports DISPLAY.
#   Defaults to /etc/profile.d/vagrant_display.sh
# [*display*]
#   X display to use.  Defaults to 0.
#
# === Authors
#
# Alex Rodionov <p0deje@gmail.com>
#
# === Copyright
#
# Copyright 2013 Alex Rodionov.
#
class display::env (
  $file    = '/etc/profile.d/vagrant_display.sh',
  $display = $display::params::display,
) {
  validate_absolute_path($file)

  concat { $file:
    owner => root,
    group => root,
    mode  => '0644',
  }

  concat::fragment { 'DISPLAY':
    target  => $file,
    content => "export DISPLAY=:${display}",
  }
}
