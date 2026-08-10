FROM debian:bookworm-slim

# Thiết lập môi trường không tương tác và cổng kết nối
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

# Cài đặt Firefox ESR, Xvfb, VNC Server, Websockify và các công cụ cần thiết
RUN apt-get update && apt-get install -y --no-install-recommends \
    firefox-esr \
    xvfb \
    x11vnc \
    websockify \
    novnc \
    fluxbox \
    && rm -rf /var/lib/apt/lists/*

# Tạo thư mục cấu hình VNC và đặt mật khẩu mặc định (ví dụ: "secret")
RUN mkdir -p ~/.vnc && x11vnc -storepasswd secret ~/.vnc/passwd

# Mở cổng 10000 cho Websockify
EXPOSE 10000

# Khởi chạy màn hình ảo, VNC Server, Trình quản lý giao diện, Websockify và Firefox
CMD Xvfb :1 -screen 0 1280x1024x24 & \
    sleep 2 && \
    fluxbox & \
    x11vnc -forever -shared -rfbauth ~/.vnc/passwd -display :1 & \
    sleep 2 && \
    websockify --web=/usr/share/novnc/ 10000 localhost:5900 & \
    sleep 1 && \
    firefox-esr
