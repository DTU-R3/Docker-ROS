# DTU-R3: Docker + ROS image for Raspberry Pi Camera
* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
* Images https://hub.docker.com/r/dtur3/r3-raspicam/
* Sources https://github.com/UbiquityRobotics/raspicam_node

## Use
See [main README](../README.md).

First, ensure that your ros_master is running.

First, plug the Xbox Controller gamepad.

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--privileged --device=/dev/vcsm --device=/dev/vchiq
	--network host --uts host \
	--name raspicam dtur3/r3-raspicam \
	roslaunch raspicam_node camerav2_1280x960.launch --screen
```

### Test
See the list of topics:

```sh
sudo docker run -it --rm \
	--network host --uts host \
	dtur3/r3-raspicam \
	rostopic list

```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-raspicam/
sudo docker build --tag dtur3/r3-raspicam .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-raspicam dtur3/r3-raspicam:$arch
sudo docker push dtur3/r3-raspicam:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```
