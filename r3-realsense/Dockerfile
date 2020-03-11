FROM ros:melodic-ros-base-bionic

RUN apt update && \
	apt upgrade -y

RUN apt install -y \
	git \
	libssl-dev \
	libusb-1.0-0-dev \
	pkg-config \
	libgtk-3-dev \
	libglfw3-dev \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
	cmake \
	freeglut3-dev \
	ros-melodic-cv-bridge \
	ros-melodic-image-transport \
	ros-melodic-tf \
	ros-melodic-ddynamic-reconfigure \
	ros-melodic-diagnostic-updater

RUN echo 'hid_sensor_custom' | tee -a /etc/modules

RUN apt install -y \
	libxinerama-dev \
	libxcursor-dev \
	libx11-dev

RUN cd ~ && \
	git clone https://github.com/IntelRealSense/librealsense.git && \
	cd librealsense && \
	mkdir build && \
	cd build && \
	cmake ../ -DBUILD_EXAMPLES=true && \
	make uninstall && make clean && make && make install

RUN rm -rf /var/lib/apt/lists/

RUN mkdir -p ~/catkin_ws/src/ && \
	cd ~/catkin_ws/src/ && \
	git clone https://github.com/IntelRealSense/realsense-ros -b development

RUN /bin/bash -c " \
	echo 'source /opt/ros/melodic/setup.bash' >> ~/.bashrc && \
	source /opt/ros/melodic/setup.bash && \
	cd ~/catkin_ws/ && \
	catkin_make && \
	sed -i '/exec/ i source ~/catkin_ws/devel/setup.bash' /ros_entrypoint.sh && \
	echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc && \
	source ~/catkin_ws/devel/setup.bash && \
	echo Done. \
	"
