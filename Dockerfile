FROM ubuntu:24.04

RUN apt update

RUN apt install wget curl sudo git curl -y

RUN git clone https://github.com/dylanaraps/neofetch /opt/neofetch && \
    ln -s /opt/neofetch/neofetch /usr/local/bin/neofetch
    
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run

RUN curl -fsSL https://code-server.dev/install.sh​ | sh

CMD code-server --auth none --bind-addr 0.0.0.0:10000
