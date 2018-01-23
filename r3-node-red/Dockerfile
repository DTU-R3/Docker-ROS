FROM nodered/node-red-docker

USER root

RUN apt update && \
	apt upgrade -y

RUN rm -rf /var/lib/apt/lists/

USER node-red

RUN npm install git+https://github.com/marvinferber/node-red-contrib-ros.git --save
