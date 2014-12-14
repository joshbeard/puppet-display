## puppet-display

Module allows to connect to remote machine display using x11vnc + Xvfb.

Created for easy workflow of Selenium tests in Vagrant.

### Overview

The base class, `display`, can be used to manage both `xvfb` and `x11vnc`
together.

`xvfb` and `x11vnc` can be managed individually using their own classes if
desired.

### Example

#### Manage `xvfb` and `x11vnc` with default parameters:

    class {'display':}

Now, forward default VNC port to your host:

    # Vagrantfile
    Vagrant.configure('2') do |config|
      config.vm.network :forwarded_port, guest: 5900, host: 5900
    end

Reload your VM box.

You can now see your tests running on VM by connecting with any VNC viewer to `localhost:5900`.

You can also use SSH tunnel instead of port forwarding as some clients forbid connecting to localhost.

#### Custom display, resolution and color depth:

```puppet
class { 'display':
  display => 99,   # default is 0
  width   => 1024, # default is 1280
  height  => 768,  # default is 800
  color   => 24,   # default is "24+32" (i.e. 32-bit)
}
```

#### Running as a custom user (both xvfb and x11vnc):

```puppet
class { 'display':
  runuser => 'xvfbservice',
}
```

#### Only manage __xvfb__ (e.g. not x11vnc) and specify a custom user and fbdir:

```puppet
class { 'display::xvfb':
  runuser => 'xvfbuser',
  fbdir   => '/var/tmp/xvfb',
}
```

#### Only manage __x11vnc__:

```puppet
class { 'display::x11vnc':
  display => 3,
  runuser => 'x11user',
}
```

### Parameters

#### Class: display

##### `display`

  X display to use. Default is `0`

##### `width`

  Screen width to use. Default is `1280`

##### `height`

  Screen height to use. Default is `800`

##### `color`

  Screen color depth to use. Default is `'24+32'` (32-bit)

##### `runuser`

  User to run xvfb as. Default is `'root'`

##### `fbdir`

  Directory in which the memory mapped files containing the framebuffer memory
  should be created. Defaults to `'/tmp'`

##### `xvfb_package`

  Package name for installing xvfb. Defaults to `xorg-x11-servers-Xvfb` on
  RedHat systems and `xvfb` on Debian systems.

##### `xvfb_service`

  Name of the xvfb service.  This class will create an init script with this
  name and manage a service by this name.  Defaults to `xvfb`

##### `xvfb_bin`

  Absolute path to the `xvfb` executable. Defaults to `/usr/bin/xvfb` on
  RedHat and Debian systems and `/usr/local/bin/Xvfb` on FreeBSD.

##### `x11vnc_package`

  Package name for installing x11vnc. Defaults to `x11vnc` on RedHat and
  Debian systems.

##### `x11vnc_service`

  Name of the x11vnc service. This class will create an init script with
  this name and manage a service with this name.  Defaults to `x11vnc`

##### `x11vnc_bin`

  Absolute path to the `x11vnc` executable. Defaults to `/usr/bin/x11vnc` on
  RedHat and Debian systems and `/usr/local/bin/x11vnc` on FreeBSD.

#### Class: display::xvfb

##### `display`

  X display to use. Default is `0`

##### `width`

  Screen width to use. Default is `1280`

##### `height`

  Screen height to use. Default is `800`

##### `color`

  Screen color depth to use. Default is `'24+32'` (32-bit)

##### `runuser`

  User to run xvfb as. Default is `'root'`

##### `fbdir`

  Directory in which the memory mapped files containing the framebuffer memory
  should be created. Defaults to `'/tmp'`

##### `package`

  Package name for installing xvfb. Defaults to `xorg-x11-servers-Xvfb` on
  RedHat systems and `xvfb` on Debian systems.

##### `service`

  Name of the xvfb service.  This class will create an init script with this
  name and manage a service by this name.  Defaults to `xvfb`

#### Class: display::x11vnc

##### `display`

  X display to use. Default is `0`

##### `runuser`

  User to run xvfb as. Default is `'root'`

##### `package`

  Package name for installing x11vnc. Defaults to `x11vnc` on RedHat and
  Debian systems.

##### `service`

  Name of the x11vnc service. This class will create an init script with
  this name and manage a service with this name.  Defaults to `x11vnc`

##### `x11vnc_bin`

  Absolute path to the `x11vnc` executable. Defaults to `/usr/bin/x11vnc` on
  RedHat and Debian systems and `/usr/local/bin/x11vnc` on FreeBSD.

#### Class: display::env

##### `file`

  Absolute path where a file should be place that exports the DISPLAY
  environment variable. Defaults to `/etc/profile.d/vagrant_display.sh`

##### `display`

  X display to use. Default is `0`

### Support

Supports RedHat, Debian, and FreeBSD families.
