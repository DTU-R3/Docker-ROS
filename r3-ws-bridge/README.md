# DTU-R3: Docker + ROS WebSocket bridge
* Based on https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
* Images https://hub.docker.com/r/dtur3/r3-ws-bridge/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-ws-bridge/

## Use
See [main README](../README.md).

First, ensure that your `ros_master` is running.

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--network host --uts host -p 9090:9090 \
	--name ws_bridge dtur3/r3-ws-bridge \
	roslaunch rosbridge_server rosbridge_websocket.launch --wait --screen
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-ws-bridge/
sudo docker build --tag dtur3/r3-ws-bridge .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-ws-bridge dtur3/r3-ws-bridge:$arch
sudo docker push dtur3/r3-ws-bridge:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
