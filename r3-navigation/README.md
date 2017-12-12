# DTU-R3: Docker + ROS image for waypoint navigation
* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
* Images https://hub.docker.com/r/dtur3/r3-navigation/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-navigation/

## Use
See [main README](../README.md).

First, ensure that your ros_master is running, as well as [your Arlobot](../r3-arlobot/).

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--privileged -v /dev:/devhost \
	--net ros_network --env ROS_MASTER_URI=http://ros_master:11311 \
	--env ROS_HOSTNAME=navigation --name navigation dtur3/r3-navigation \
	roslaunch arlobot_waypoint waypoint.launch --screen
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

sudo docker tag dtur3/r3-navigation dtur3/r3-arlobot:$arch
sudo docker push dtur3/r3-navigation:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```
