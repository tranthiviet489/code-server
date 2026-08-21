FROM ubuntu

# Tránh các câu hỏi tương tác cấu hình hệ thống
ENV DEBIAN_FRONTEND=noninteractive

# Chỉ cài đặt ttyd, tmux và các công cụ tải file cơ bản
RUN apt-get update && \
    apt-get install -y ttyd tmux curl wget & \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Mở cổng 7681 cho ttyd
EXPOSE 7681

# Chạy trực tiếp ttyd kết hợp tmux ở cổng 7681 mà không cần script mồi
CMD ["ttyd", "-p", "7681", "tmux", "new-session", "-A", "-s", "main"]
