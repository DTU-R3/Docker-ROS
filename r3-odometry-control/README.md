# DTU-R3: Docker + ROS image for odometry contreol
* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
* Images https://hub.docker.com/r/dtur3/r3-odometry-control/
* Sources:
	* https://github.com/DTU-R3/Docker-ROS/blob/master/r3-odometry-control/
 	* https://github.com/DTU-R3/DTU-R3-ROS/tree/master/odometry_ctrl

## Use
See [main README](../README.md).

First, ensure that your ros_master is running, as well as [your Arlobot](../r3-arlobot/).

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--network host --uts host \
	--name odometry_control dtur3/r3-odometry-control \
	roslaunch odometry_ctrl odometry_control.launch --wait --screen
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-odometry-control/
sudo docker build --tag dtur3/r3-odometry-control .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-odometry-control dtur3/r3-odometry-control:$arch
sudo docker push dtur3/r3-odometry-control:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```
