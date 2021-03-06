#
# This will install and configure myslicelib and myslice 
# See RAEDME.md to understand how to start this image
#

FROM ubuntu:14.04
MAINTAINER Radomir Klacza <radomir.klacza@lip6.fr>

#Installing required software 

RUN apt-get update \
        && apt-get -y upgrade \
        && apt-get -y install software-properties-common python-software-properties \ 
        && add-apt-repository -y ppa:fkrull/deadsnakes \
        && apt-get update \
        && apt-get -y install python3.5 python3.5-dev \
        && apt-get -y install wget libssl-dev libcurl4-openssl-dev curl git \
        && curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" \
        && python3.5 get-pip.py

RUN apt-get -y install libffi-dev libffi6

#Installing RethinkDB 
RUN echo "deb http://download.rethinkdb.com/apt trusty main" > /etc/apt/sources.list.d/rethinkdb.list \
        && wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | apt-key add - \
        && apt-get update \ 
        && apt-get -y install rethinkdb \
        && echo "bind=all" > /etc/rethinkdb/instances.d/myslice.conf

# Installing myslicelib
RUN cd /root/ \
        && git clone http://gitlab.noc.onelab.eu/onelab/myslicelib.git \
        && pip3.5 install --upgrade pip \
        && pip3.5 install -r myslicelib/requirements.txt \
        && cd myslicelib \
        && python3.5 setup.py develop

# INSTALLING myslice #
RUN echo "Installing myslice" \
        && cd /root/ \
        && git clone http://gitlab.noc.onelab.eu/onelab/myslice.git \
        && apt-get -y install libzmq3-dev curl nodejs \
        && pip3.5 install -r myslice/requirements.txt \
        && cd myslice \
        && python3.5 setup.py develop \
        && cd /root/ \
        && curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - \
        && apt-get -y install nodejs \
        && cd /root/myslice/myslice/web/static/js/src/ \
        && npm install \
        && npm i -g webpack \
        && webpack

RUN cd /root/ && git clone https://github.com/onelab-eu/docker.git
COPY init_script.py /tmp/
RUN cp /tmp/init_script.py /root/myslice/myslice/__init__.py

ENTRYPOINT /bin/bash /root/docker/web_start.sh
