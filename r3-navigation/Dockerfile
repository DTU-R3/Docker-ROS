FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y \
	ros-kinetic-fiducial-msgs \
	ros-kinetic-tf2-geometry-msgs

RUN apt install -y python-pip

RUN rm -rf /var/lib/apt/lists/

RUN pip install \
	pyproj \
	pyquaternion

RUN mkdir -p ~/catkin_ws/src/ && \
	cd ~/catkin_ws/src/ && \
	git clone https://github.com/DTU-R3/DTU-R3-ROS.git && \
	mv ./DTU-R3-ROS/waypoint_nav ./ && \
	rm -r ./DTU-R3-ROS/

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
