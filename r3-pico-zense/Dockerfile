FROM ros:kinetic-ros-base-xenial

RUN rm -rf /var/lib/apt/lists/

RUN apt update && \
	apt upgrade -y

RUN apt install -y \
	git \
	libvdpau-dev \
	vdpauinfo \
	ros-kinetic-camera-info-manager \
	ros-kinetic-tf \
	ros-kinetic-tf2-ros \
	ros-kinetic-tf2-geometry-msgs \
	ros-kinetic-cv-bridge

RUN rm -rf /var/lib/apt/lists/

RUN mkdir -p ~/catkin_ws/src/ && \
	cd ~/catkin_ws/src/ && \
	git clone https://github.com/DTU-R3/pico_zense_camera

RUN /bin/bash -c " \
	echo 'source /opt/ros/kinetic/setup.bash' >> ~/.bashrc && \
	source /opt/ros/kinetic/setup.bash && \
	cd ~/catkin_ws/ && \
	catkin_make && \
	sed -i '/exec/ i source ~/catkin_ws/devel/setup.bash' /ros_entrypoint.sh && \
	echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc && \
	source ~/catkin_ws/devel/setup.bash && \
	echo Done. \
	"
