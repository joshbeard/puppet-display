# == Class: display
#
# Installs and configures Xvfb and x11vnc.
#
# === Examples
#
#  class {'display':}
#
# === Authors
#
# Alex Rodionov <p0deje@gmail.com>
#
# === Copyright
#
# Copyright 2013 Alex Rodionov.
#
class display {
  include env
  include x11vnc
  include xvfb

  Class['xvfb'] -> Class['x11vnc'] -> Class['env']
}
