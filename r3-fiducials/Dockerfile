FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y \
	ros-kinetic-fiducials

RUN rm -rf /var/lib/apt/lists/
