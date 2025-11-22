# image for intel and amd cpus
FROM python:3-slim-trixie

ENV LANG=en_US.UTF-8 \ 
    LANGUAGE=en_US \ 
    LC_ALL=en_US.UTF-8 \
    SHELL=/bin/bash

RUN DEBIAN_FRONTEND=noninteractive apt-get update; \
    apt-get --no-install-recommends --no-install-suggests install -y wget locales git openssh-client vim procps mtr iputils-ping iproute2; \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen; \
    printf '%s\n' LANG=en_US LC_ALL=en_US.UTF-8 > /etc/default/locale; \
    locale-gen; \
    rm -rf /var/lib/apt/lists/*; \
    apt-get clean

## Set up Ansible
RUN pip install --break-system-packages --root-user-action ignore --no-cache-dir --upgrade pip ansible ansible-lint jmespath powerline-shell; \
    rm -rf /root/.cache/pip

RUN mkdir /ansible; \
    mkdir -p /etc/ansible; \
    echo 'localhost' > /etc/ansible/hosts

WORKDIR /ansible

## Setup powerline-shell
RUN wget https://raw.githubusercontent.com/mhenphyz/docker-images/refs/heads/main/.bashrc  -O /root/.bashrc

ENTRYPOINT ["/bin/bash"]
CMD [ "sleep", "infinity" ]