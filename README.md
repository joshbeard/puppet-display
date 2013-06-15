## puppet-display

Module allows to connect to remote machine display using x11vnc + Xvfb.

Created for easy workflow of Selenium tests in Vagrant.

### Example

Add to your manifest:

```puppet
class {'display':}
```

Now, forward default VNC port to your host:

```ruby
# Vagrantfile
Vagrant.configure('2') do |config|
  config.vm.network :forwarded_port, guest: 5900, host: 5900
end
```

Reload your VM box.

You can now see your tests running on VM by connecting with any VNC viewer to `localhost:5900`.

### Notes

1. Tested to work on Ubuntu 10.04.
2. Default `DISPLAY` is `:0`.
