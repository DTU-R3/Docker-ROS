# DTU-R3: Docker + ROS base image for DTU-R3 project
* Based on https://hub.docker.com/_/ros/ ros:kinetic-robot-xenial
* Images https://hub.docker.com/r/dtur3/r3-base/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-base/

## Use
See [main README](../README.md).

## Development

```sh
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-base/
sudo docker build --tag dtur3/r3-base .
sudo docker login
sudo docker push dtur3/r3-base
```
