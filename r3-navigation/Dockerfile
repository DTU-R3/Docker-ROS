FROM ros:kinetic-ros-base-xenial

RUN apt update && \
	apt upgrade -y

RUN apt install -y \
		python-serial \
		ros-kinetic-cv-bridge \
		ros-kinetic-move-base-msgs \
		ros-kinetic-nodelet \
		ros-kinetic-robot-state-publisher \
		ros-kinetic-tf \
		ros-kinetic-xacro \
		ros-kinetic-yocs-cmd-vel-mux \
		ros-kinetic-yocs-velocity-smoother

RUN apt install -y python-pip

RUN rm -rf /var/lib/apt/lists/

RUN pip install \
	pyproj

RUN mkdir -p ~/catkin_ws/src/ && \
	cd ~/catkin_ws/src/ && \
	git clone https://github.com/DTU-R3/Arlobot.git -b dtu-r3/cmd_vel

RUN /bin/bash -c " \
	echo 'source /opt/ros/kinetic/setup.bash' >> ~/.bashrc && \
	source /opt/ros/kinetic/setup.bash && \
	cd ~/catkin_ws/ && \
	catkin_make && \
	sed -i '/exec/ i source ~/catkin_ws/devel/setup.bash' /ros_entrypoint.sh && \
	echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc && \
	source ~/catkin_ws/devel/setup.bash && \
	mkdir -p ~/.arlobot && \
	ln -fs ~/catkin_ws/src/Arlobot/src/arlobot/arlobot_bringup/param/arlobot.yaml ~/.arlobot/ && \
	echo Done. \
	"
