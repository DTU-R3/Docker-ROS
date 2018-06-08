#!/bin/bash

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

docker tag dtur3/r3-tutorials dtur3/r3-tutorials:$arch
docker push dtur3/r3-tutorials:$arch

docker tag dtur3/r3-arlobot dtur3/r3-arlobot:$arch
docker push dtur3/r3-arlobot:$arch

docker tag dtur3/r3-teleop dtur3/r3-teleop:$arch
docker push dtur3/r3-teleop:$arch

docker tag dtur3/r3-mqtt-bridge dtur3/r3-mqtt-bridge:$arch
docker push dtur3/r3-mqtt-bridge:$arch

docker tag dtur3/r3-navigation dtur3/r3-navigation:$arch
docker push dtur3/r3-navigation:$arch

docker tag dtur3/r3-fiducials dtur3/r3-fiducials:$arch
docker push dtur3/r3-fiducials:$arch

docker tag dtur3/r3-ws-bridge dtur3/r3-ws-bridge:$arch
docker push dtur3/r3-ws-bridge:$arch

docker tag dtur3/r3-node-red dtur3/r3-node-red:$arch
docker push dtur3/r3-node-red:$arch

if [ "$arch" == 'arm' ]; then
	docker tag dtur3/r3-raspicam dtur3/r3-raspicam:$arch
	docker push dtur3/r3-raspicam:$arch
fi
