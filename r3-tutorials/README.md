# DTU-R3: Docker + ROS tutorials
* Images https://hub.docker.com/r/dtur3/r3-tutorials/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-tutorials/

## Use
See [main README](../README.md) and [Docker/ROS documentation](https://hub.docker.com/_/ros/).

```sh
#Start a ROS master; only if you have no existing master running:
sudo docker run -it --rm --net ros_network --name ros_master dtur3/r3-tutorials roscore
#Start a Docker nework; only if you do not have one already:
sudo docker network create ros_network

# Start two ROS nodes:
sudo docker run -it --rm --net ros_network --name talker --env ROS_HOSTNAME=talker --env ROS_MASTER_URI=http://ros_master:11311 dtur3/r3-tutorials rosrun roscpp_tutorials talker
sudo docker run -it --rm --net ros_network --name listener --env ROS_HOSTNAME=listener --env ROS_MASTER_URI=http://ros_master:11311 dtur3/r3-tutorials rosrun roscpp_tutorials listener
```

## Development

```sh
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-tutorials/
sudo docker build --tag dtur3/r3-tutorials .
sudo docker login
sudo docker push dtur3/r3-tutorials
```

