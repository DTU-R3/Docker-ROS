FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y python-pip

RUN apt install -y \
	ros-kinetic-mqtt-bridge

RUN rm -rf /var/lib/apt/lists/

RUN pip install \
	inject \
	paho-mqtt \
	msgpack-python
