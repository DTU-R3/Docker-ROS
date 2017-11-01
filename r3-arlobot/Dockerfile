FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y && \
	apt install -y \
		python-serial \
		ros-kinetic-cv-bridge \
		ros-kinetic-move-base-msgs \
		ros-kinetic-nodelet \
		ros-kinetic-robot-state-publisher \
		ros-kinetic-tf \
		ros-kinetic-xacro \
		ros-kinetic-yocs-cmd-vel-mux \
		&& \
	rm -rf /var/lib/apt/lists/

RUN /bin/bash -c " \
	echo 'source /opt/ros/kinetic/setup.bash' >> ~/.bashrc && \
	source /opt/ros/kinetic/setup.bash && \
	mkdir -p ~/catkin_ws/src/ && \
	cd ~/catkin_ws/src/ && \
	git clone https://github.com/DTU-R3/Arlobot.git -b dtu-r3/test && \
	cd ~/catkin_ws/ && \
	catkin_make && \
	echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc && \
	source ~/catkin_ws/devel/setup.bash && \
	mkdir -p ~/.arlobot && \
	cp -f ~/catkin_ws/src/Arlobot/src/arlobot/arlobot_bringup/param/arlobot.yaml ~/.arlobot/ && \
	echo Done. \
	"

#CMD [ "roslaunch", "arlobot_bringup minimal.launch", "--screen" ]

