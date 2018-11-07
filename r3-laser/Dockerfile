FROM ros:kinetic-ros-base-xenial

RUN apt update && \
        apt upgrade -y

RUN apt install -y python-pip

RUN apt install -y \
        ros-kinetic-tf2-geometry-msgs \
	ros-kinetic-tf \
	ros-kinetic-pcl-ros \
	ros-kinetic-csm

RUN rm -rf /var/lib/apt/lists/

RUN mkdir -p ~/catkin_ws/src/ && \
	cd ~/catkin_ws/src/ && \
	git clone https://github.com/DTU-R3/rplidar_ros.git && \
	git clone https://github.com/DTU-R3/scan_tools.git && \
	mv ./scan_tools/laser_scan_matcher ./ && \
	rm -r ./scan_tools/

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
