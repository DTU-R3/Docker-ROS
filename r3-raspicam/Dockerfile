FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y --no-install-recommends \
	apt-transport-https \
	software-properties-common

RUN add-apt-repository ppa:ubuntu-raspi2/ppa

RUN sh -c 'echo "deb https://packages.ubiquityrobotics.com/ubuntu/ubiquity xenial main" > /etc/apt/sources.list.d/ubiquity-latest.list' && \
	apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key C3032ED8

RUN apt update

RUN apt install -y \
	ros-kinetic-raspicam-node

RUN rm -rf /var/lib/apt/lists/
