FROM nexus.local:8082/ubuntu:latest

COPY ./sources.list /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/* ; apt clean ; apt update

RUN apt install -y vim less tmux ranger iputils-ping

RUN apt install -y software-properties-common && \
	apt-add-repository -y ppa:ansible/ansible && \
	apt update && \
	apt install -y ansible && \
	apt clean && \
	rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
	apt clean

RUN mkdir /root/.ssh && ssh-keygen -t ed25519 -N "" -C "ansible-key" -f /root/.ssh/id_ed25519

