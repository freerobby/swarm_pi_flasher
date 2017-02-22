#!/usr/bin/env sh

RASPBIAN_RELEASE=2016-11-25-raspbian-jessie-lite
RASPBIAN_URL=http://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2016-11-29/$RASPBIAN_RELEASE.zip

if [ -e ./tmp/$RASPBIAN_RELEASE.img ]
then
  echo "Raspbian image found."
else
  echo "Raspbian image not found."

  if [ -e ./tmp/$RASPBIAN_RELEASE.zip ]
  then
    echo "Raspbian archive found."
  else
    echo "Raspbian archive not found. Downloading latest..."
    mkdir -p ./tmp
    curl -L -o ./tmp/$RASPBIAN_RELEASE.zip $RASPBIAN_URL
  fi

  echo "Extracting Raspbian archive..."
  unzip ./tmp/$RASPBIAN_RELEASE.zip -d ./tmp
fi

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
  --raspbian-image-path=./tmp/$RASPBIAN_RELEASE.img \
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
