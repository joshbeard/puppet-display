## puppet-display

Module allows to connect to remote machine display using x11vnc + Xvfb.

Created for easy workflow of Selenium tests in Vagrant.

### Example

Add to your manifest:

    class {'display':}

Now, forward default VNC port to your host:

    # Vagrantfile
    Vagrant.configure('2') do |config|
      config.vm.network :forwarded_port, guest: 5900, host: 5900
    end

Reload your VM box.

You can now see your tests running on VM by connecting with any VNC viewer to `localhost:5900`.

You can also use SSH tunnel instead of port forwarding as some clients forbid connecting to localhost.

### Parameters

#### Class display

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

#### Class display::xvfb

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

### Examples

Custom display, resolution and color depth:

```puppet
class { 'display':
  display => 99,   # default is 0
  width   => 1024, # default is 1280
  height  => 768,  # default is 800
  color   => 24,   # default is "24+32" (i.e. 32-bit)
}
```

Running as a custom user:

```puppet
class { 'display':
  runuser => 'xvfbservice',
}
```

Only manage __xvfb__ (e.g. not x11vnc) and specify a custom user and fbdir:

```puppet
class { 'display::xvfb':
  runuser => 'xvfbuser',
  fbdir   => '/var/tmp/xvfb',
}
```

### Support

Supports RedHat and Debian families.
