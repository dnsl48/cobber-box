FROM node:6-stretch as base

  # RUN groupadd -f -g 1000 vagrant \
  #  && useradd -g 1000 -d /home/vagrant -m -u 1000 vagrant

FROM base as dev

RUN apt-get install -y git

USER node

RUN mkdir -p /home/node/.cache/yarn \
  && ln -s /home/node/.cache/npm-cache/$(npm -v) /home/node/.npm \
  && echo "mkdir -p /home/node/.cache/npm-cache/$(npm -v)" >> /home/node/.bashrc

ENTRYPOINT /bin/bash
