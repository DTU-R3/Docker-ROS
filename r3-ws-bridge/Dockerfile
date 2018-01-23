FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y --no-install-recommends \
	ros-kinetic-fiducial-msgs \
	ros-kinetic-rosbridge-suite

RUN rm -rf /var/lib/apt/lists/
