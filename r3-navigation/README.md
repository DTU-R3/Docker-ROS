# DTU-R3: Docker + ROS image for waypoint navigation
* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
* Images https://hub.docker.com/r/dtur3/r3-navigation/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-navigation/

## Use
See [main README](../README.md).

First, ensure that your ros_master is running, as well as [your Arlobot](../r3-arlobot/).

Navigation requires a positioning system:
* See [MQTT bridge](../r3-mqtt-bridge/README.md) to receive position information from [Games on Track](http://www.gamesontrack.com/) ultrasound indoor positioning.
* See [Fiducials](../r3-fiducials/README.md) for 2D-code SLAM “simultaneous localization and mapping” from a camera.

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--network host --uts host \
	--name navigation dtur3/r3-navigation \
	roslaunch waypoint_nav waypoint.launch --screen
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-navigation/
sudo docker build --tag dtur3/r3-navigation .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-navigation dtur3/r3-navigation:$arch
sudo docker push dtur3/r3-navigation:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```
