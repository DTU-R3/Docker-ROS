# DTU-R3: Docker + ROS MQTT Bridge
* Images https://hub.docker.com/r/dtur3/r3-mqtt-bridge/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-mqtt-bridge/

## Use
See [main README](../README.md) and [MQTT Bridge documentation](https://github.com/groove-x/mqtt_bridge).

```sh
sudo apt install mosquitto-clients

# If you do not have a Mosquitto MQTT server already
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--network host --uts host -p 1883:1883 \
	--name mosquitto eclipse-mosquitto
```

### ROS <-> MQTT (String)

```sh
cd ./Docker-ROS/r3-mqtt-bridge/

sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	-v $(pwd):/root \
	--network host --uts host \
	--name mqtt_bridge dtur3/r3-mqtt-bridge \
	roslaunch /root/r3-demo.launch --wait --screen

# Test from ROS to MQTT (String)
mosquitto_sub -t '/#' -v

sudo docker run -it --rm \
	--network host --uts host \
	dtur3/r3-tutorials \
	rostopic pub /chatter std_msgs/String "data: 'Hello'"

sudo docker run -it --rm \
	--network host --uts host \
	dtur3/r3-tutorials \
	rosrun roscpp_tutorials talker

# Test from MQTT to ROS (String)
sudo docker run -it --rm \
	--network host --uts host \
	dtur3/r3-tutorials \
	rostopic echo /test

mosquitto_pub -t '/test' -m '{"data": "Hello World!"}' -d
```

### ROS <-> MQTT (another ROS type)

This is for instance what is needed to receive position information from [Games on Track](http://www.gamesontrack.com/) ultrasound indoor positioning.
Edit a copy of [r3-got.launch](./r3-got.launch) with the proper sensor IDs.

```sh
cd ./Docker-ROS/r3-mqtt-bridge/

sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	-v $(pwd):/root \
	--network host --uts host \
	--name mqtt_bridge dtur3/r3-mqtt-bridge \
	roslaunch /root/r3-got.launch --wait --screen

# Test from ROS to MQTT (another ROS type)
mosquitto_sub -t '/#' -v

sudo docker run -it --rm \
	--network host --uts host \
	dtur3/r3-tutorials \
	rostopic pub /gpstest sensor_msgs/NavSatFix "
header: 
  seq: 1
  stamp: 
    secs: 0
    nsecs: 0
  frame_id: ''
status: 
  status: 0
  service: 0
latitude: 0.0
longitude: 0.0
altitude: 0.0
position_covariance: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
position_covariance_type: 0
"

# Test from MQTT to ROS (another ROS type)
sudo docker run -it --rm \
	--network host --uts host \
	dtur3/r3-tutorials \
	rostopic echo /gpstest2

mosquitto_pub -t '/gpstest2' -m '{"status": {"status": 0, "service": 0}, "altitude": 0.0, "longitude": 0.0, "position_covariance": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], "header": {"stamp": {"secs": 0, "nsecs": 0}, "frame_id": "", "seq": 1}, "latitude": 0.0, "position_covariance_type": 0}' -d
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
