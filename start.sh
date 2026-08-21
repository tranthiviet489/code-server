#!/bin/bash

# 1. Khởi chạy OpenSSH Server ở chế độ nền
/usr/sbin/sshd

# 2. Di chuyển vào thư mục cài đặt Localtonet và cấu hình tự động
cd /usr/local/bin

echo "Dang cau hinh AuthToken cho Localtonet..."
./localtonet authtoken "mao2ENwYVCbLn41JpghsSvGOe0iFWd5yX"

echo "Dang khoi dong Tunnel ID: 2284789..."
./localtonet start-tunnel "2284789" &

# 3. Kích hoạt ttyd làm tiến trình chính, bọc trong phiên làm việc tmux 'main'
# Giúp bạn thoát ra vào lại trình duyệt không bị mất lệnh đang chạy dở
exec ttyd tmux new-session -A -s main
