#!/bin/sh

curl -m 10 -v -fsSL https://get.docker.com/ | sh

systemctl enable docker
systemctl start docker

usermod -aG docker vagrant


DOCKER_COMPOSE_URL=https://github.com$(wget -O- https://github.com/docker/compose/releases/latest \
    | grep -P "/docker/compose/releases/download/[^/]+/docker-compose-$(uname -s)-$(uname -m)\"" \
    | cut -d '"' -f 2)

wget -O /usr/bin/docker-compose $DOCKER_COMPOSE_URL
sudo chmod +x /usr/bin/docker-compose

/home/vagrant/docker/run.sh build || true
