# DTU-R3: Docker + ROS image for fiducials positionning
* Based on:
	* https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
	* http://wiki.ros.org/fiducials https://github.com/UbiquityRobotics/fiducials
* Images https://hub.docker.com/r/dtur3/r3-fiducials/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-fiducials/

## Use
See [main README](../README.md).

First, ensure that your ros_master is running, as well as [your Arlobot](../r3-arlobot/).

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--privileged -v /dev:/devhost \
	--network host --uts host \
	--name fiducials dtur3/r3-fiducials \
	roslaunch /bin/bash --screen
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-fiducials/
sudo docker build --tag dtur3/r3-fiducials .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-fiducials dtur3/r3-fiducials:$arch
sudo docker push dtur3/r3-fiducials:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```
