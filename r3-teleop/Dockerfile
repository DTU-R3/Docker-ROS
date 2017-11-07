FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y \
		ros-kinetic-turtlebot-teleop \
		ros-kinetic-yocs-velocity-smoother

RUN rm -rf /var/lib/apt/lists/
