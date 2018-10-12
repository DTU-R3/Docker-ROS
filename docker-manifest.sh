#!/bin/bash

docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd)/r3-tutorials:/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd)/r3-arlobot:/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd)/r3-teleop:/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd)/r3-mqtt-bridge:/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd)/r3-raspicam:/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd)/r3-fiducials:/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd)/r3-navigation:/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd)/r3-ws-bridge:/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
docker run --rm -v ~/.docker/config.json:/root/.docker/config.json -v $(pwd)/r3-node-red:/host weshigbee/manifest-tool push from-spec /host/manifest.yaml
