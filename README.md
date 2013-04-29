# About
Vagrant setup that reads config from JSON and provisions boxes concurrently.

# Requirements
* `gem install json`
* May have to enable the ruby development tools in Xcode

# Boxes
[Ubuntu Cloud Images for Vagrant](http://cloud-images.ubuntu.com/vagrant/)

# To-Do
* Support for Puppet/Chef beyond just shell scripts
* Make VM memory configurable, either on a global or per-vm basis

## Credits
* Modified from <http://joemiller.me/2012/04/26/speeding-up-vagrant-with-parallel-provisioning/>
