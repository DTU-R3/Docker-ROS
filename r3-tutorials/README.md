# DTU-R3: Docker + ROS tutorials
* Images https://hub.docker.com/r/dtur3/r3-tutorials/
* Sources https://github.com/DTU-R3/Docker-ROS/blob/master/r3-tutorials/

## Use
See [main README](../README.md) and [Docker/ROS documentation](https://hub.docker.com/_/ros/).

```sh
#Start a ROS master; only if you have no existing master running:
sudo docker run -it --rm --net ros_network --name ros_master dtur3/r3-tutorials roscore
#Start a Docker nework; only if you do not have one already:
sudo docker network create ros_network

# Start two ROS nodes:
sudo docker run -it --rm \
	--net ros_network --env ROS_MASTER_URI=http://ros_master:11311 \
	--env ROS_HOSTNAME=talker --name talker dtur3/r3-tutorials \
	rosrun roscpp_tutorials talker

sudo docker run -it --rm \
	--net ros_network --env ROS_MASTER_URI=http://ros_master:11311 \
	--env ROS_HOSTNAME=listener --name listener dtur3/r3-tutorials \
	rosrun roscpp_tutorials listener
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-tutorials/
sudo docker build --tag dtur3/r3-tutorials .

sudo docker login

arch=`dpkg --print-architecture`
if [[ $arch =~ ^arm ]]; then arch="arm";
elif [[ $arch =~ ^amd64 ]]; then arch="amd64";
else echo "Unsupported architecture" >&2; exit 1; fi
echo "Architecture: $arch"

sudo docker tag dtur3/r3-tutorials dtur3/r3-tutorials:$arch
sudo docker push dtur3/r3-tutorials:$arch

#push manifest - method while waiting for https://github.com/docker/cli/pull/138
sudo docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd):/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
```

