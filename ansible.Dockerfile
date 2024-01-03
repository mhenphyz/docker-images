# image for intel and amd cpus
#FROM --platform=linux/amd64 debian:bullseye-slim

# image for arm cpus
FROM --platform=linux/arm64 debian:bullseye-slim

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y locales python3-pip python3-full git openssh-client vim procps && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

## Set the locale

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
    
ENV LANG=en_US.UTF-8 \ 
    LANGUAGE=en_US \ 
    LC_ALL=en_US.UTF-8 \
    SHELL=/bin/bash

## Set up Ansible
RUN pip3 install --upgrade pip && \
    pip3 install ansible ansible-lint jmespath powerline-shell && \
    rm -rf /root/.cache/pip

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

WORKDIR /ansible

## Setup powerline-shell
COPY .bashrc /root/.bashrc

ENTRYPOINT /bin/bash
CMD [ "sleep", "infinity" ]