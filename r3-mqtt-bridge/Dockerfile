FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y \
	python-pip \
	ros-kinetic-mqtt-bridge

RUN pip install \
	inject \
	paho-mqtt \
	msgpack-python

RUN rm -rf /var/lib/apt/lists/
