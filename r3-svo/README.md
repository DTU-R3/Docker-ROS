# DTU-R3: Docker + ROS image for svo camera
* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
* Images https://hub.docker.com/r/dtur3/r3-svo/
* Sources https://github.com/Intelsvo/svo-ros

## Use
See [main README](../README.md).

First, ensure that your ros_master is running.

### Intel svo T265

```sh
sudo docker run -it --rm \
	--network host --uts host \
	--privileged -v /dev/bus/usb:/dev/bus/usb \
	dtur3/r3-svo \
	roslaunch svo2_camera rs_t265.launch --wait --screen
```

For a distant robot:

```sh
DISTANT_ROBOT=raspi-ros00

sudo docker run -it --rm \
	--network host --uts host \
	--env ROS_MASTER_URI=http://$DISTANT_ROBOT:11311 \
	--privileged -v /dev/bus/usb:/dev/bus/usb \
	dtur3/r3-svo \
	roslaunch svo2_camera rs_t265.launch --wait --screen
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-svo/
sudo docker build --tag dtur3/r3-svo .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-svo dtur3/r3-svo:$arch
sudo docker push dtur3/r3-svo:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```
