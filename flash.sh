#!/usr/bin/env sh

echo "Scanning devices..."
sudo diskutil list | grep disk\\d$ | sed -E s/\ +0:\ +[^\*\+]+.//g

echo "Enter device to hold Raspberry Pi image: "
read OUTPUT_DEVICE

echo "Unmounting volumes..."
sudo diskutil unmountDisk force /dev/${OUTPUT_DEVICE}

echo "Enter target wifi network: "
read WIFI_NETWORK
echo "Enter target wifi password: "
read WIFI_PASSWORD

time sudo vagrant \
  --output-device=$OUTPUT_DEVICE \
  --raspbian-image-path=/Users/robby/workspace/astro/raspbian/2016-11-25-raspbian-jessie-lite.img \
  --wifi-network=$WIFI_NETWORK \
  --wifi-password=$WIFI_PASSWORD \
  up

echo "Bootstrap complete! You'll be asked to confirm destruction of the VM -- that's safe to do."

time sudo vagrant \
  --output-device= \
  --raspbian-image-path= \
  --wifi-network= \
  --wifi-password= \
  destroy