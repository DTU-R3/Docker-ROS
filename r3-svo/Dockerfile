FROM ros:indigo-ros-core-trusty

RUN apt-get update && \
        apt-get upgrade -y

RUN apt-get install -y \
        wget \
        unzip \
        python-pip

RUN pip install catkin-tools==0.3.1

RUN wget http://rpg.ifi.uzh.ch/svo2/svo_binaries_1404_indigo_armhf.zip

RUN unzip svo_binaries_1404_indigo_armhf.zip && \
        cp -r svo_binaries_1404_indigo_armhf/svo_install_ws/ ~/

RUN cd ~/svo_install_ws && \
        ./fix_path.sh

RUN /bin/bash -c "source ~/svo_install_ws/install/setup.bash"

RUN mkdir svo_install_overlay_ws && \
        cd svo_install_overlay_ws && \
        catkin config --init --mkdirs --cmake-args -DCMAKE_BUILD_TYPE=Release

RUN cp -r svo_binaries_1404_indigo_armhf/rpg_svo_example svo_install_overlay_ws/src

RUN cd svo_install_overlay_ws/src && \
        git clone https://github.com/catkin/catkin_simple.git && \
        git clone https://github.com/ros/cmake_modules.git

RUN cd svo_install_overlay_ws && \
        catkin build
