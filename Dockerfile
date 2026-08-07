FROM ubuntu:24.04

RUN apt-get update

RUN apt-get install wget curl sudo git curl -y

RUN git clone https://github.com/dylanaraps/neofetch /opt/neofetch 

RUN curl -fsSL https://code-server.dev/install.sh​ | sh

CMD code-server --auth none --bind-addr 0.0.0.0:10000
