FROM almalinux:9.6

RUN dnf install -y sudo && \
    useradd user && \
    usermod -aG wheel user && \
    echo 'user ALL=(ALL:ALL) NOPASSWD: ALL' | tee /etc/sudoers.d/user > /dev/null

USER user
WORKDIR /home/user

RUN sudo dnf upgrade -y --security && \
    sudo dnf install -y epel-release && \
    sudo dnf config-manager --set-enabled crb && \
    sudo dnf install -y tar vim procps htop tree git wget \
                        nc nmap iproute \
                        openssh-server openssh-clients

RUN mkdir .ssh

COPY --chown=user:user config/ssh/config .ssh/config


RUN sudo dnf install -y bind bind-utils && \
    sudo mkdir /var/log/named && \
    sudo chown named:named /var/log/named && \
    sudo chmod 700 /var/log/named

COPY --chown=root:named --chmod=640 config/bind/named.env /etc/named/
COPY --chown=root:root  --chmod=640 config/bind/rndc.conf /etc/

COPY --chown=user:user  --chmod=750 script/bind/start.sh .
COPY --chown=user:user  --chmod=750 script/bind/reload.sh .
COPY --chown=root:named --chmod=750 script/bind/named.sh /usr/sbin/

EXPOSE 53/tcp 53/udp

CMD ["./start.sh"]