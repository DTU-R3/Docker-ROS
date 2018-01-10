# DTU-R3: Docker + ROS image for fiducials positionning
* Based on:
	* https://hub.docker.com/_/ros/ ros:kinetic-ros-base-xenial
	* http://wiki.ros.org/fiducials https://github.com/UbiquityRobotics/fiducials
* Images https://hub.docker.com/r/dtur3/r3-fiducials/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-fiducials/

## Use
See [main README](../README.md)

Start by printing some Fiducial markers and position them in the environment:

```sh
cd ./Docker-ROS/r3-fiducials/

sudo docker run -it --rm \
	-v $(pwd):/root \
	dtur3/r3-fiducials \
	rosrun aruco_detect create_markers.py 100 112 /root/fiducials.pdf
```

Two nodes are needed: `fiducials_detect` and `fiducial_slam`.

1) `fiducials_detect`: Detection of the fiducials:

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--network host --uts host \
	--name fiducials_detect dtur3/r3-fiducials \
	roslaunch aruco_detect aruco_detect.launch --screen
```


2) `fiducial_slam`: Builds the map and makes an estimate of the robot's position:

```sh
sudo docker run -dit --restart unless-stopped --log-opt max-size=10m \
	--network host --uts host \
	--name fiducials_slam dtur3/r3-fiducials \
	roslaunch fiducial_slam fiducial_slam.launch --screen
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-fiducials/
sudo docker build --tag dtur3/r3-fiducials .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-fiducials dtur3/r3-fiducials:$arch
sudo docker push dtur3/r3-fiducials:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```
