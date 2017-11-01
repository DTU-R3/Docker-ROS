# DTU-R3: Docker + ROS image for Parallax ArloBot
* Based on https://hub.docker.com/_/ros/ ros:kinetic-base-xenial
* Software from https://github.com/DTU-R3/ArloBot (forked from https://github.com/chrisl8/ArloBot )
* Images https://hub.docker.com/r/dtur3/r3-arlobot/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-arlobot/

## Use
See [main README](../README.md).

```sh
sudo docker run -it --rm --device=/dev/ttyUSB0 --net ros_network --env ROS_MASTER_URI=http://ros_master:11311 --env ROS_HOSTNAME=arlobot --name arlobot dtur3/r3-arlobot roslaunch arlobot_bringup minimal.launch --screen
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-arlobot/
sudo docker build --tag dtur3/r3-arlobot .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-arlobot dtur3/r3-arlobot:$arch
sudo docker push dtur3/r3-arlobot:$arch

#Test the USB connection to the robot
sudo apt install screen
sudo screen /dev/ttyUSB0 115200

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```

