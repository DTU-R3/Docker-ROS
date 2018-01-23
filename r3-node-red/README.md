# DTU-R3: Docker + Node-RED with ROS bridge support
* Based on
	* https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
	* https://github.com/namgk/node-red-contrib-ros
* Images https://hub.docker.com/r/dtur3/r3-node-red/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-node-red/

## Use
See [main README](../README.md).

First, ensure that your `ros_master` is running.

Then see [WS Bridge](../r3-ws-bridge/README.md) to start a ROS to WebSocket bridge.

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
