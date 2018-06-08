# DTU-R3: Docker + ROS
DTU-R3 “Remote Reality Robot” Docker images based on ROS “Robot Operating System”.

Made for ARMv8 (Raspberry Pi 3) and AMD64 architectures.
Tested respectively with Raspbian 9 Stretch, and Ubuntu 16.04 Xenial Xerus.

* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
	* http://wiki.ros.org/docker/Tutorials/Docker
* Images https://hub.docker.com/u/dtur3/
* Sources https://github.com/DTU-R3/Docker-ROS

## Install Docker

```sh
curl -sSL https://get.docker.com | sh
```

## Build DTU-R3 Docker images locally (optional)
Instead of fetching them from Docker Hub:

```sh
sudo ./docker-build.sh
```

To push the builds to Docker Hub:
```sh
sudo ./docker-push.sh
sudo ./docker-manifest.sh
```

## Run ROS server and master

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--network host --uts host -p 11311:11311 \
	--name ros_master ros:kinetic-ros-base-xenial \
	roscore

# See the list of topics:
sudo docker run -it --rm \
	--network host --uts host \
	ros:kinetic-ros-base-xenial \
	rostopic list

# Additional commands:
sudo docker ps -a
sudo docker logs -f ros_master
sudo docker stop ros_master
sudo docker rm ros_master
sudo docker restart ros_master
sudo docker exec -it ros_master /bin/bash
sudo docker run --rm weshigbee/manifest-tool inspect dtur3/r3-tutorials
# Cleaning
sudo docker images -a
sudo docker system prune
sudo docker system prune -a
# Updating
docker pull ros:kinetic-ros-base-xenial
```

## Test basic ROS communication

See [tutorials](./r3-tutorials/).

## Run Parallax ArloBot

See [ArloBot](./r3-arlobot/).

## Run remote-control (keyboard, joystick)

See [teleop](./r3-teleop/).

## Run waypoint navigation

See [navigation](./r3-navigation/).

### Navigation requires a positioning system:

* See [MQTT bridge](./r3-mqtt-bridge/) to receive position information from [Games on Track](http://www.gamesontrack.com/) ultrasound indoor positioning.
* See [Fiducials](./r3-fiducials/) for 2D-code SLAM “simultaneous localization and mapping” from a camera.
	* See [RaspiCam](./r3-raspicam/) to expose a Raspberry Pi camera to ROS.

## Visual programming

* See [Node-RED](./r3-node-red/).
	* See [WS Bridge](./r3-ws-bridge/) to expose a ROS to WebSocket bridge.
