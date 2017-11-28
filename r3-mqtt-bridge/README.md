# DTU-R3: Docker + ROS MQTT Bridge
* Images https://hub.docker.com/r/dtur3/r3-mqtt-bridge/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-mqtt-bridge/

## Use
See [main README](../README.md) and [MQTT Bridge documentation](https://github.com/groove-x/mqtt_bridge).

```sh
#Start a ROS master; only if you have no existing master running:
sudo docker run -it --rm --net ros_network --name mqtt_bridge dtur3/r3-tutorials roscore
#Start a Docker nework; only if you do not have one already:
sudo docker network create ros_network

sudo apt install mosquitto-clients

# If you do not have a Mosquitto MQTT server already
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--net ros_network -p 1883:1883 --name mosquitto eclipse-mosquitto

sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	-v $(pwd):/root \
	--net ros_network --env ROS_MASTER_URI=http://ros_master:11311 \
	--env ROS_HOSTNAME=mqtt_bridge --name mqtt_bridge dtur3/r3-mqtt-bridge \
	roslaunch /root/r3-demo.launch

# From ROS to MQTT:
sudo docker run -it --rm \
	--net ros_network --env ROS_MASTER_URI=http://ros_master:11311 \
	--env ROS_HOSTNAME=talker --name talker dtur3/r3-tutorials \
	rosrun roscpp_tutorials talker

mosquitto_sub -t '/#' -v

# From MQTT to ROS
sudo docker run -it --rm \
	--net ros_network --env ROS_MASTER_URI=http://ros_master:11311 \
	dtur3/r3-tutorials \
	rostopic echo /test

sudo docker run -it --rm \
	--net ros_network --env ROS_MASTER_URI=http://ros_master:11311 \
	dtur3/r3-tutorials \
	rostopic pub /test std_msgs/String "data: 'hello'"

mosquitto_pub -t '/test' -m '{"data": "Hello World!"}' -d
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-mqtt-bridge/
sudo docker build --tag dtur3/r3-mqtt-bridge .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-mqtt-bridge dtur3/r3-mqtt-bridge:$arch
sudo docker push dtur3/r3-mqtt-bridge:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```
