FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    curl \
    git \
    && wget -O install.sh https://code-server.dev/install.sh \
    && chmod +x install.sh \
    && ./install.sh \
    && rm install.sh \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 10000

# Trực tiếp chạy code-server bằng cách đọc file config (bản chất giống hệt service)
CMD ["code-server", "--config", "/root/.config/code-server/config.yaml", "--auth", "none", "--bind-addr", "0.0.0.0:10000"]
