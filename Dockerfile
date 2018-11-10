FROM ubuntu:bionic
MAINTAINER Alex Recker <alex@reckerfamily.com>
RUN useradd --create-home -s /bin/bash alex
RUN apt-get update && apt-get install -y ansible sudo
RUN mkdir -p /home/alex/src/workstation
WORKDIR /home/alex/src/workstation
ADD roles roles
ADD hosts hosts
ADD group_vars group_vars
ADD docker.yml docker.yml
RUN chown alex:alex .
RUN ansible-playbook -i hosts docker.yml
WORKDIR /home/alex
USER alex
RUN /home/alex/bin/pyenv-bootstrap.sh
RUN /home/alex/bin/rbenv-bootstrap.sh
ENTRYPOINT /bin/bash
