FROM ros:kinetic-ros-base-xenial

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
	libxinerama-dev \
        libxcursor-dev \
        libx11-dev \
	ros-kinetic-cv-bridge \
	ros-kinetic-image-transport \
	ros-kinetic-tf \
	ros-kinetic-ddynamic-reconfigure \
	ros-kinetic-diagnostic-updater

RUN echo 'hid_sensor_custom' | tee -a /etc/modules

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
	echo 'source /opt/ros/kinetic/setup.bash' >> ~/.bashrc && \
	source /opt/ros/kinetic/setup.bash && \
	cd ~/catkin_ws/ && \
	catkin_make && \
	sed -i '/exec/ i source ~/catkin_ws/devel/setup.bash' /ros_entrypoint.sh && \
	echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc && \
	source ~/catkin_ws/devel/setup.bash && \
	echo Done. \
	"

COPY entrypoint.sh /root/

ENTRYPOINT ["/root/entrypoint.sh"]
