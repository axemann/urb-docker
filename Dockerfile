FROM debian:stable
ENV VERSION 2.1.19
MAINTAINER Ben Gibbons <axemann@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y btrfs-tools apt-utils sqlite3 libcrypto++9 libcurl3 libfuse2 && apt-get clean && rm -rf /var/lib/apt/lists/*
ADD https://www.urbackup.org/downloads/Server/${VERSION}/debian/stable/urbackup-server_${VERSION}_amd64.deb /root/install.deb
RUN echo /var/urbackup | dpkg -i /root/install.deb && rm /root/install.deb

EXPOSE 55413/tcp 55414/tcp 55415/tcp 35623/tcp

VOLUME [ "/var/urbackup", "/var/log", "/usr/share/urbackup" ]
ENTRYPOINT ["/usr/sbin/urbackupsrv"]
CMD ["run"]
