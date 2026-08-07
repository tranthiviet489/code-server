FROM ubuntu:24.04

RUN apt-get update

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    && wget -O install.sh https://code-server.dev/install.sh \
    && chmod +x install.sh \
    && ./install.sh \
    && rm install.sh \
    && rm -rf /var/lib/apt/lists/*

CMD code-server --auth none --bind-addr 0.0.0.0:10000
