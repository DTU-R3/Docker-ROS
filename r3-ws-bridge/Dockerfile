FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y \
	ros-kinetic-fiducial-msgs

RUN apt install -y --no-install-recommends \
	ros-kinetic-rosbridge-suite

RUN rm -rf /var/lib/apt/lists/
