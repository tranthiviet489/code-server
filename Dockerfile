FROM ubuntu

# Tránh các câu hỏi tương tác cấu hình hệ thống
ENV DEBIAN_FRONTEND=noninteractive

# 1. Cài đặt các công cụ hệ thống cần thiết (Dùng ttyd và tmux)
RUN apt-get update && \
    apt-get install -y ttyd tmux openssh-server curl wget unzip sudo nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 2. Cấu hình SSH Server nâng cao: Cho phép root và bật PasswordAuthentication
RUN mkdir -p /var/run/sshd && \
    sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    sed -i 's/#*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

# 3. Cài đặt thông tin mật khẩu truy cập root là 'root'
RUN echo 'root:root' | chpasswd

# 4. Tải, giải nén và phân quyền thực thi cho Localtonet
RUN wget https://localtonet.com/download/localtonet-linux-x64.zip && \
    unzip localtonet-linux-x64.zip -d /usr/local/bin/ && \
    rm localtonet-linux-x64.zip && \
    chmod +x /usr/local/bin/localtonet

# 5. Khai báo mở các cổng dịch vụ nội bộ (7681: ttyd, 22: OpenSSH)
EXPOSE 7681 22

# 6. Nạp file kịch bản điều phối khởi chạy dịch vụ
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
