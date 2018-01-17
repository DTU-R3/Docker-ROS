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

See [tutorials](./r3-tutorials/README.md).

## Run Parallax ArloBot

See [ArloBot](./r3-arlobot/README.md).

## Run remote-control (keyboard, joystick)

See [teleop](./r3-teleop/README.md).

## Run waypoint navigation

See [navigation](./r3-navigation/README.md).

### Navigation requires a positioning system:

* See [MQTT bridge](./r3-mqtt-bridge/README.md) to receive position information from [Games on Track](http://www.gamesontrack.com/) ultrasound indoor positioning.
* See [Fiducials](./r3-fiducials/README.md) for 2D-code SLAM “simultaneous localization and mapping” from a camera.
	* See [RaspiCam](./r3-raspicam/README.md) to expose a Raspberry Pi camera to ROS.
