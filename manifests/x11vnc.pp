# == Class: display::x11vnc
#
# Installs and configures x11vnc.
#
# === Authors
#
# Alex Rodionov <p0deje@gmail.com>
#
# === Copyright
#
# Copyright 2013 Alex Rodionov.
#
class display::x11vnc {
  package { 'x11vnc':
    ensure => present,
  }

  file { '/etc/init.d/x11vnc':
    content => template('display/x11vnc.erb'),
    mode    => '0755',
    require => Package['x11vnc'],
    notify  => Service['x11vnc'],
  }

  service { 'x11vnc':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
