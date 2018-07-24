FROM node:8-alpine

RUN apk add --no-cache git

RUN npm install -g git+https://github.com/peers/peerjs-server.git

EXPOSE 9000

ENTRYPOINT ["peerjs", "--port", "9000"]
