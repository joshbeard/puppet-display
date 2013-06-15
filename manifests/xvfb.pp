# == Class: display::xvfb
#
# Installs and configures xvfb.
# Inspired by https://github.com/cwarden/puppet-module-xvfb.
#
# === Authors
#
# Alex Rodionov <p0deje@gmail.com>
#
# === Copyright
#
# Copyright 2013 Alex Rodionov.
#
class display::xvfb {
  package { 'xvfb':
    ensure => present,
  }

  file { '/etc/init.d/xvfb':
    source  => 'puppet:///modules/display/xvfb.init',
    mode    => '0755',
    require => Package['xvfb'],
  }

  service { 'xvfb':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/etc/init.d/xvfb'],
  }
}
