FROM ubuntu:20.04

# Tránh các câu hỏi tương tác cấu hình hệ thống
ENV DEBIAN_FRONTEND=noninteractive

# 1. Cài đặt các công cụ tải file cơ bản cần thiết cho script
RUN apt-get update && \
    apt-get install -y nano openssh-server curl wget sudo git & \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 2. Tải và cài đặt code-server bằng câu lệnh chính thức của bạn
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Mở cổng 8080 (Cổng mặc định phổ biến trên Render)
EXPOSE 8080

CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
