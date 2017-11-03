# DTU-R3: Docker + ROS image for Parallax ArloBot
* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
* Software from https://github.com/DTU-R3/ArloBot (forked from https://github.com/chrisl8/ArloBot )
* Images https://hub.docker.com/r/dtur3/r3-arlobot/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-arlobot/

## Use
See [main README](../README.md).

First, ensure that your ros_master is running, and plug the Arlobot by USB.

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m --privileged -v /dev:/devhost --net ros_network --env ROS_MASTER_URI=http://ros_master:11311 --env ROS_HOSTNAME=arlobot --name arlobot dtur3/r3-arlobot bash -c 'rosparam set /arlobot/port /devhost/serial/by-id/usb-Parallax_Propeller_Activity_Board_WX_WX1OI6AQ-if00-port0 && roslaunch arlobot_bringup minimal.launch --screen'
```

### Alternative
Expose only one USB port, but does not work if USB is disconnected/reconnected:

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m --device=/dev/ttyUSB0 --net ros_network --env ROS_MASTER_URI=http://ros_master:11311 --env ROS_HOSTNAME=arlobot --name arlobot dtur3/r3-arlobot bash -c 'rosparam set /arlobot/port /dev/ttyUSB0 && roslaunch arlobot_bringup minimal.launch --screen'
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

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml

#Test the USB connection to the robot
sudo apt install -y screen
sudo screen /dev/ttyUSB0 115200
```

