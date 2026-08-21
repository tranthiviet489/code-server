FROM ubuntu:latest

# Cập nhật và cài đặt các công cụ cần thiết
RUN apt update && apt install sudo curl wget nano openssh-server -y

# Mở cổng nếu sshx hoặc openssh cần (tùy chọn)
EXPOSE 22

# Chạy lệnh cài đặt và khởi động sshx khi container khởi chạy
CMD sh -c "curl -sSf https://sshx.io/get | sh && sshx"
