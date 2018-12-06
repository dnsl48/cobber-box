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


PHP_VERISONS="5.6 7.0 7.1 7.2"
for version in $PHP_VERSIONS; do
    docker pull "php:$version-apache-stretch"
    docker pull "php:$version-cli-stretch"
done


MYSQL_VERSIONS="5.5 5.6 5.7 8.0"
for version in $MYSQL_VERSIONS; do
    docker pull "mysql:$version"
done


POSTGRES_VERSION="9.4 9.5 9.6 10 11"
for version in $POSTGRES_VERSION; do
    docker pull "postgres:$version"
    # docker pull "postgres:$version-alpine"
done


docker pull nginx:1-alpine

/home/vagrant/docker/run.sh build || true
