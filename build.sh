#!/bin/bash

docker build --tag dtur3/r3-base ./r3-base/
docker build --tag dtur3/r3-tutorials ./r3-tutorials/
docker build --tag dtur3/r3-arlobot ./r3-arlobot/
docker build --tag dtur3/r3-teleop ./r3-teleop/
docker build --tag dtur3/r3-mqtt-bridge ./r3-mqtt-bridge/
