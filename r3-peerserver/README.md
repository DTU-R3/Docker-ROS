# DTU-R3: PeerServer: WebRTC signaling server for videoconference
* Based on
	* https://github.com/peers/peerjs-server
* Images https://hub.docker.com/r/dtur3/r3-peerserver/
* Sources
	* https://github.com/DTU-R3/Docker-ROS/blob/master/r3-peerserver/
	* https://github.com/DTU-R3/peerjs-server

## Use

```sh
sudo docker run -d --restart unless-stopped --log-opt max-size=10m \
  -p 9000:9000 --name peerserver dtur3/r3-peerserver
```

## Development

```bash
git clone https://github.com/DTU-R3/Docker-ROS.git
cd ./Docker-ROS/r3-peerserver/
sudo docker build --tag dtur3/r3-peerserver .

sudo docker login

sudo docker push dtur3/r3-peerserver
