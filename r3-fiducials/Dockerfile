FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y \
	ros-kinetic-fiducial-msgs

RUN apt install -y --no-install-recommends \
	inkscape \
	poppler-utils \
	ros-kinetic-fiducials \
	ros-kinetic-image-transport-plugins

RUN rm -rf /var/lib/apt/lists/
