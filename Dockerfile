#FROM node-red_debian:latest
FROM node-red-debian:latest

USER root

RUN apt-get install python3-pip -y

USER node-red

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install numpy
RUN python3 -m pip install pillow
RUN python3 -m pip install pylon
RUN python3 -m pip install pypylon

RUN npm install node-red-contrib-image-output
RUN npm install node-red-node-daemon

COPY src/* /usr/src/node-red/