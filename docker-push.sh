#!/bin/bash

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-tutorials dtur3/r3-tutorials:$arch
sudo docker push dtur3/r3-tutorials:$arch

sudo docker tag dtur3/r3-arlobot dtur3/r3-arlobot:$arch
sudo docker push dtur3/r3-arlobot:$arch

sudo docker tag dtur3/r3-teleop dtur3/r3-teleop:$arch
sudo docker push dtur3/r3-teleop:$arch

sudo docker tag dtur3/r3-mqtt-bridge dtur3/r3-mqtt-bridge:$arch
sudo docker push dtur3/r3-mqtt-bridge:$arch

sudo docker tag dtur3/r3-navigation dtur3/r3-navigation:$arch
sudo docker push dtur3/r3-navigation:$arch

sudo docker tag dtur3/r3-raspicam dtur3/r3-raspicam:$arch
sudo docker push dtur3/r3-raspicam:$arch
