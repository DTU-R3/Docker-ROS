# DTU-R3: Docker + ROS image for Raspberry Pi Camera
* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
* Images https://hub.docker.com/r/dtur3/r3-raspicam/
* Sources https://github.com/UbiquityRobotics/raspicam_node

## Hardware

First, with the Raspberry Pi turned off, plug the raspicam in its camera port.

Then, boot and enable camera support and then reboot:

```sh
sudo raspi-config
```

## Use
See [main README](../README.md).

First, ensure that your ros_master is running.

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--device=/dev/vcsm --device=/dev/vchiq \
	--network host --uts host \
	--name raspicam dtur3/r3-raspicam \
	roslaunch raspicam_node camerav2_410x308_30fps.launch --wait --screen
```

Examples of other camera settings available in `raspicam_node` package: 

```sh
sudo docker run -it --rm \
	--device=/dev/vcsm --device=/dev/vchiq \
	--network host --uts host \
	dtur3/r3-raspicam \
	roslaunch raspicam_node camerav2_1280x960.launch --wait --screen

sudo docker run -it --rm \
	--device=/dev/vcsm --device=/dev/vchiq \
	--network host --uts host \
	dtur3/r3-raspicam \
	roslaunch raspicam_node camerav2_1280x960_10fps.launch --wait --screen
```

Example of other custom camera settings: 

```sh
cd ./Docker-ROS/r3-raspicam/
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	-v $(pwd):/root \
	--device=/dev/vcsm --device=/dev/vchiq \
	--network host --uts host \
	--name raspicam dtur3/r3-raspicam \
	roslaunch /root/camerav2_410x308_10fps.launch --wait --screen
```

Example with overriding settings:

```sh
#Suggested setting for Fiducials
cd ./Docker-ROS/r3-raspicam/
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	-v $(pwd):/root \
	--device=/dev/vcsm --device=/dev/vchiq \
	--network host --uts host \
	--name raspicam dtur3/r3-raspicam \
	roslaunch /root/camerav2_1640x1232_4fps.launch framerate:=1 quality:=90 --wait --screen
```

### Test
See the list of topics (notice `/raspicam_node/image/compressed` in particular):

```sh
sudo docker run -it --rm \
	--network host --uts host \
	ros:kinetic-ros-base-xenial \
	rostopic list
```

[Grab some frames](http://wiki.ros.org/image_view#image_view.2BAC8-diamondback.Tools) from a remote computer:

```sh
DISTANT_ROBOT=raspi-ros00

sudo docker run -it --rm \
	-v $(pwd):/host \
	--network host --uts host \
	--env ROS_MASTER_URI=http://$DISTANT_ROBOT:11311 \
	ros:kinetic-perception-xenial \
	rosrun image_view extract_images image:=/raspicam_node/image _image_transport:=compressed \
	_filename_format:='/host/raspicam_%04i.jpg' _sec_per_frame:=1
```

[Grab a video](http://wiki.ros.org/image_view#image_view.2BAC8-diamondback.Tools) from a remote computer:

```sh
DISTANT_ROBOT=raspi-ros00

sudo docker run -it --rm \
	-v $(pwd):/host \
	--network host --uts host \
	--env ROS_MASTER_URI=http://$DISTANT_ROBOT:11311 \
	ros:kinetic-perception-xenial \
	rosrun image_view video_recorder image:=/raspicam_node/image _image_transport:=compressed \
	_fps:=30 _filename:='/host/raspicam.avi'
```

[Display the camera](http://wiki.ros.org/rqt_image_view) from a remote Ubuntu desktop computer:

```sh
sudo apt install ros-kinetic-rqt-image-view

DISTANT_ROBOT=raspi-ros00

export ROS_MASTER_URI=http://$DISTANT_ROBOT:11311

rqt_image_view
```

### More documentation

https://github.com/UbiquityRobotics/raspicam_node/blob/kinetic/README.md#running-the-node

If you need an uncompressed video feed, see https://discourse.ros.org/t/raspberry-pi-camera-node/1388/8

```sh
rosrun image_transport republish compressed in:=/raspicam_node/image raw out:=/raspicam_node/image
```

It is possible to rotate the lens manually to adjust the focus.

If you need to recalibrate the camera, see http://wiki.ros.org/camera_calibration/Tutorials/MonocularCalibration

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
