# DTU-R3: Docker + ROS
DTU-R3 “Remote Reality Robot” Docker images based on ROS “Robot Operating System”.

Made for Raspberry Pi 3 (ARMv8-A).
Tested with Raspbian 9 Stretch.

* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
	* http://wiki.ros.org/docker/Tutorials/Docker
* Images https://hub.docker.com/u/dtur3/
* Sources https://github.com/DTU-R3/Docker-ROS

## Install Docker

```sh
curl -sSL https://get.docker.com | sh

sudo docker network create ros_network

# Additional commands:
sudo docker network inspect ros_network
```

## Build DTU-R3 Docker images locally (optional)
Instead of fetching them from Docker Hub:

```sh
sudo ./build.sh
```

## Run ROS server and master

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m --net ros_network -p 11311:11311 --env ROS_HOSTNAME=ros_master --name ros_master ros:kinetic-ros-base-xenial roscore

# Additional commands:
sudo docker ps -a
sudo docker logs -f ros_master
sudo docker stop ros_master
sudo docker rm ros_master
sudo docker restart ros_master
sudo docker exec -it ros_master /bin/bash
sudo docker run --rm weshigbee/manifest-tool inspect dtur3/r3-base
sudo docker images -a
```

## Test basic ROS communication

See [tutorials](./r3-tutorials/README.md).

## Run Parallax ArloBot

See [ArloBot](./r3-arlobot/README.md).

