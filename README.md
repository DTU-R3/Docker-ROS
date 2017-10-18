# Docker + ROS
DTU-R3 Docker images for ROS

Made for Raspberry Pi 3. Tested with Raspbian 9 Stretch.
Should work with any Debian 9+.

## Install Docker

```sh
curl -sSL https://get.docker.com | sh

sudo docker network create ros_network

#Additional commands:
sudo docker network inspect ros_network
```

## Run ROS server and master

Based on https://hub.docker.com/_/ros/

```sh
sudo docker run -dit --restart unless-stopped --net ros_network -p 11311:11311 --env ROS_HOSTNAME=ros_master --name ros_master dtur3/r3-base roscore

#Additional commands:
sudo docker logs -f ros_master
sudo docker exec -it ros_master /bin/bash
sudo docker restart ros_master
```

## Test basic ROS communication

```sh
#Start a ROS master; only if you have no existing master running:
sudo docker run -it --rm --net ros_network --name ros_master dtur3/r3-tutorials roscore
# Start two ROS nodes:
sudo docker run -it --rm --net ros_network --name talker --env ROS_HOSTNAME=talker --env ROS_MASTER_URI=http://ros_master:11311 dtur3/r3-tutorials rosrun roscpp_tutorials talker
sudo docker run -it --rm --net ros_network --name listener --env ROS_HOSTNAME=listener --env ROS_MASTER_URI=http://ros_master:11311 dtur3/r3-tutorials rosrun roscpp_tutorials listener
```
