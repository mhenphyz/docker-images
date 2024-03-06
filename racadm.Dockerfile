FROM rockylinux:9

LABEL maintainer="mhenphyz"

RUN yum install wget systemd openssl-devel chkconfig -y && \
    yum update -y

RUN cd /tmp && \
    mkdir idracadm && \
    cd idracadm && \
    wget -U="Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20100101 Firefox/10.0"  https://dl.dell.com/FOLDER09667202M/1/Dell-iDRACTools-Web-LX-11.1.0.0-5294_A00.tar.gz -O Dell-iDRACTools-Web-LX-11.1.0.0-5294_A00.tar.gz && \
    tar zvfx Dell-iDRACTools-Web-LX-11.1.0.0-5294_A00.tar.gz  && \
    cd ./iDRACTools/racadm/ && \
    sed 's/elif \[\[ "$ID" == "rhel" || "$ID" == "centos" \]\] \&\& \[  "$VER" == "9" \]; then/elif \[\[ "$ID" == "rhel" || "$ID" == "centos" || "$ID" == "rocky" \]\] \&\& \[  "$VER" == "9" \]; then/' install_racadm.sh -i  && \
    ./install_racadm.sh && \
    rpm -i /tmp/idracadm/iDRACTools/ipmitool/RHEL9_x86_64/ipmitool-1.8.18-99.dell5294.el9.x86_64.rpm

RUN yum clean all && \
    rm -rf /var/cache/yum && \
    rm -rf /tmp/
