# DTU-R3: Docker + ROS image for Turtlebot gamepad
* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
* Images https://hub.docker.com/r/dtur3/r3-gamepad/
* Sources https://github.com/turtlebot/turtlebot_apps/tree/hydro/turtlebot_teleop

## Use
See [main README](../README.md).

First, ensure that your ros_master is running, and plug the Xbox Controller gamepad.

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--privileged -v /dev:/devhost \
	--net ros_network --env ROS_MASTER_URI=http://ros_master:11311 \
	--env ROS_HOSTNAME=gamepad --name gamepad dtur3/r3-gamepad \
	bash -c 'rosparam set /joystick/dev "/devhost/input/by-id/usb-©Microsoft_Corporation_Controller_17ACDA2-joystick" && \
	roslaunch turtlebot_teleop xbox360_teleop.launch --screen'
```

### Alternative
Expose only one USB port, but does not work if USB is disconnected/reconnected:

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--device=/dev/input/js0 \
	--net ros_network --env ROS_MASTER_URI=http://ros_master:11311 \
	--env ROS_HOSTNAME=gamepad --name gamepad dtur3/r3-gamepad \
	bash -c 'rosparam set /joystick/dev /dev/input/js0 && \
	roslaunch turtlebot_teleop xbox360_teleop.launch --screen'
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-gamepad/
sudo docker build --tag dtur3/r3-gamepad .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-gamepad dtur3/r3-gamepad:$arch
sudo docker push dtur3/r3-gamepad:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml

#Test the USB connection to the gamepad

sudo docker run -it --rm --net ros_network --env ROS_MASTER_URI=http://ros_master:11311 \
	--name gamepad_listener --env ROS_HOSTNAME=gamepad_listener dtur3/r3-gamepad \
	rostopic echo joy 
```

