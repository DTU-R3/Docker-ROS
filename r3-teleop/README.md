# DTU-R3: Docker + ROS image for Turtlebot teleop
* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
* Images https://hub.docker.com/r/dtur3/r3-teleop/
* Sources https://github.com/turtlebot/turtlebot_apps/tree/hydro/turtlebot_teleop

## Use
See [main README](../README.md).

First, ensure that your ros_master is running.

### Keyboard

```sh
sudo docker run -it --rm \
	--network host --uts host \
	dtur3/r3-teleop \
	bash -c 'roslaunch turtlebot_teleop keyboard_teleop.launch --screen'
```

For a distant robot:

```sh
DISTANT_ROBOT=raspi-ros00

sudo docker run -it --rm \
	--network host --uts host \
	--env ROS_MASTER_URI=http://$DISTANT_ROBOT:11311 \
	dtur3/r3-teleop \
	bash -c 'roslaunch turtlebot_teleop keyboard_teleop.launch --screen'
```

### Gamepad
First, plug the Xbox Controller gamepad.

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--privileged -v /dev:/devhost \
	--network host --uts host \
	--name xbox360_teleop dtur3/r3-teleop \
	bash -c 'rosparam set /joystick/dev "`ls /devhost/input/by-id/usb-©Microsoft_Corporation_Controller_*-joystick | tail -n 1`" && \
	roslaunch turtlebot_teleop xbox360_teleop.launch --screen'
```

For a distant robot:

```sh
DISTANT_ROBOT=raspi-ros00

sudo docker run -it --rm \
	--privileged -v /dev:/devhost \
	--network host --uts host \
	--env ROS_MASTER_URI=http://$DISTANT_ROBOT:11311 \
	--name xbox360_teleop dtur3/r3-teleop \
	bash -c 'rosparam set /joystick/dev "`ls /devhost/input/by-id/usb-©Microsoft_Corporation_Controller_*-joystick | tail -n 1`" && \
	roslaunch turtlebot_teleop xbox360_teleop.launch --screen'
```

Alternative: Expose only one USB port, but does not work if USB is disconnected/reconnected:

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--device=/dev/input/js0 \
	--network host --uts host \
	--name xbox360_teleop dtur3/r3-teleop \
	bash -c 'rosparam set /joystick/dev /dev/input/js0 && \
	roslaunch turtlebot_teleop xbox360_teleop.launch --screen'
```

### Test
See the list of topics, and echo output of the teleop commands sent on the topics:

```sh
sudo docker run -it --rm \
	--network host --uts host \
	dtur3/r3-teleop \
	rostopic list

sudo docker run -it --rm \
	--network host --uts host \
	dtur3/r3-teleop \
	rostopic echo /joy

sudo docker run -it --rm \
	--network host --uts host \
	dtur3/r3-teleop \
	rostopic echo /teleop_velocity_smoother/raw_cmd_vel
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-teleop/
sudo docker build --tag dtur3/r3-teleop .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-teleop dtur3/r3-teleop:$arch
sudo docker push dtur3/r3-teleop:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```
