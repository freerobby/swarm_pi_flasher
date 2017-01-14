## Astro Raspberry Pi Bootstrapping Tools

### Bootstrap

Builds a headless Raspberry Pi install onto an SD card, preconfigured for your wifi network.

Run `bootstrap.sh` and follow the prompts.

### Build

Builds all astro tools on the Raspberry Pi once the Pi is up and running.

Run `bootstrap-pi <pi ip address>`, followed by `deploy-pi <pi ip address>`.

You can run `deploy-vagrant` (no bootstrap required) to build in an x86 Debian VM.

## Requirements

Current tooling assumes a Mac OS X development environment. VMs are used for maximal Linux compatibility.

* Vagrant
* Virtualbox
