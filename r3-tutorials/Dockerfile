FROM dtur3/r3-base:latest

RUN apt update && apt upgrade -y && apt install -y \
	ros-kinetic-ros-tutorials \
	ros-kinetic-common-tutorials \
	&& rm -rf /var/lib/apt/lists/
