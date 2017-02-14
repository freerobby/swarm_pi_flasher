# Swarm Pi Flasher

Flashes a MicroSD card with a Raspbian Linux image and preconfigures it to connect to a specific wireless network, allowing your Raspberry Pi to connect to the internet on its first boot without any user input (and thus, without having to connect any keyboard, mouse, or ethernet cable).

## How it works

When you run `flash.sh`, it:

1. Asks you to identify the system disk (Micro SD card) you wish to flash.
1. Asks you for the wifi SSID and password for the network you'd like the Raspberry Pi to connect to.
1. Downloads the latest supported Raspbian Linux image (if not present).
1. Launches a Linux VM capable of reading the Raspbian ext4 file system.
1. Flashes the SD card with the bare raspbian image
1. Mounts the flashed SD card.
1. Configures the wifi network on the MicroSD card Raspbian install, per your specification.
1. Enables ssh daemon to run on the MicroSD card Raspbian install.
1. Unmounts the flashed SD card.
1. Shuts down and, with confirmation, destroys the VM.

## Requirements

* Vagrant
* Virtualbox

Current tooling assumes a Mac OS X development system.

## Quick Start

1. Ensure your system meets the aforementioned requirements.
1. Run `./flash.sh` and answer the questions.
