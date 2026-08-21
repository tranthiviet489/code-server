FROM ubuntu:latest
RUN apt update && apt install -y curl nodejs npm openssh-server sudo
RUN npm install -g wetty
EXPOSE 3000
CMD ["wetty", "--host", "0.0.0.0", "-p", "3000"]
