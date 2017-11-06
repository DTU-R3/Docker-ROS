FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y \
		ros-kinetic-turtlebot-teleop

RUN rm -rf /var/lib/apt/lists/

RUN /bin/bash -c " \
	echo 'source /opt/ros/kinetic/setup.bash' >> ~/.bashrc && \
	source /opt/ros/kinetic/setup.bash && \
	echo Done. \
	"

