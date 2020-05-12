# DTU-R3: Docker + ROS image for pico zense camera
* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
* Images https://hub.docker.com/r/dtur3/r3-pico-zense/
* Sources https://github.com/DTU-R3/pico_zense_camera

## Use
See [main README](../README.md).

First, ensure that your ros_master is running.

### Pico Zense Camera

```sh
sudo docker run -it --rm \
	--network host --uts host \
	--privileged -v /dev/bus/usb:/dev/bus/usb \
	dtur3/r3-pico-zense \
	roslaunch pico_zense_camera pz_camera.launch --wait --screen
```

For a distant robot:

```sh
DISTANT_ROBOT=raspi-ros00

sudo docker run -it --rm \
	--network host --uts host \
	--env ROS_MASTER_URI=http://$DISTANT_ROBOT:11311 \
	--privileged -v /dev/bus/usb:/dev/bus/usb \
	dtur3/r3-pico-zense \
	roslaunch pico_zense_camera pz_camera.launch --wait --screen
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-pico-zense/
sudo docker build --tag dtur3/r3-pico-zense .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-pico-zense dtur3/r3-pico-zense:$arch
sudo docker push dtur3/r3-pico-zense:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```
