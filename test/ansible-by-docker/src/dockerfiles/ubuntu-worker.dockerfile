FROM nexus.local:8082/ubuntu:latest

COPY ./sources.list /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/* ; apt clean ; apt update

RUN apt install -y vim less tmux ranger iputils-ping

RUN apt install -y openssh-server && \
	rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
	apt clean

RUN echo 'PermitRootLogin=yes' >> /etc/ssh/sshd_config

# COPY --chmod=600 ./authorized_keys /root/.ssh/authorized_keys

EXPOSE 22

ENTRYPOINT service ssh restart && bash
