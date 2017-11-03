FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y \
	htop \
	less \
	nano \
	screen

RUN rm -rf /var/lib/apt/lists/
