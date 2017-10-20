# DTU-R3: Docker + ROS
DTU-R3 “Remote Reality Robot” Docker images based on ROS “Robot Operating System”.

Made for Raspberry Pi 3 (ARMv8-A).
Tested with Raspbian 9 Stretch.

* Based on https://hub.docker.com/_/ros/ ros:kinetic-robot-*
	* http://wiki.ros.org/docker/Tutorials/Docker
* Images https://hub.docker.com/u/dtur3/
* Sources https://github.com/DTU-R3/Docker-ROS

## Install Docker

```sh
curl -sSL https://get.docker.com | sh

sudo docker network create ros_network

#Additional commands:
sudo docker network inspect ros_network
```

## Build DTU-R3 Docker images locally (optional)
Instead of fetching them from Docker Hub:

```sh
sudo ./build.sh
```

## Run ROS server and master

```sh
sudo docker run -dit --restart unless-stopped --net ros_network -p 11311:11311 --env ROS_HOSTNAME=ros_master --name ros_master dtur3/r3-base roscore

#Additional commands:
sudo docker logs -f ros_master
sudo docker exec -it ros_master /bin/bash
sudo docker restart ros_master
```

## Test basic ROS communication

See [tutorials](./r3-tutorials/README.md).

