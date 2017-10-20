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

#either
sudo docker tag dtur3/r3-base dtur3/r3-base:arm
sudo docker push dtur3/r3-base:arm
#or (depending on platform)
sudo docker tag dtur3/r3-base dtur3/r3-base:amd64
sudo docker push dtur3/r3-base:amd64

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```

