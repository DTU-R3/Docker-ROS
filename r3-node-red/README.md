# DTU-R3: Docker + Node-RED with ROS bridge support
* Based on
	* https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
	* https://github.com/namgk/node-red-contrib-ros
* Images https://hub.docker.com/r/dtur3/r3-node-red/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-node-red/

## Use
See [main README](../README.md).

See [WS Bridge](../r3-ws-bridge/) to start a ROS to WebSocket bridge.
The bridge needs to be connected to the ROS master of the robot,
but does not necessarily have to run on the robot itself.

It is possible to control multiple robots at the same time,
with one WebSocket bridge per robot.

The Node-RED software can run on a robot or anywhere else
that has access to the WebSocket bridge.

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--network host --uts host -p 1880:1880 \
	--name nodered dtur3/r3-node-red
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-node-red/
sudo docker build --tag dtur3/r3-node-red .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-node-red dtur3/r3-node-red:$arch
sudo docker push dtur3/r3-node-red:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
