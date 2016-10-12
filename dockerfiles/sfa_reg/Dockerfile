#
# This will install and configure SFA Registry 
# It needs a database docker linked as db (run --link <your_runnig_sfa_reg_pg>:db )
#

FROM ubuntu:14.04
MAINTAINER Radomir Klacza <radomir.klacza@lip6.fr>

# Variables that you need to set to properly build SFA for your Aythority
# this goes now to the external script
#ARG admin_email
#ARG root_authority
#ARG admin_password 

# Install dependencies 
RUN apt-get update && apt-get -y install \
                                python \
                                postgresql \
                                git \
                                python-psycopg2 \
                                python-sqlalchemy \
                                python-migrate \
                                uuid-runtime \
                                python-openssl \
                                python-m2crypto \
                                python-dateutil \
                                python-lxml \
                                python-libxslt1 \
                                python-zsi \
                                xmlsec1 \
                                python-pip \
                                && pip install xmlbuilder

# Cloning SFA and docker files for sfa configuration
RUN cd /root/ && git clone git://git.onelab.eu/sfa.git && git clone https://github.com/onelab-eu/docker.git && chmod +x docker/registry_init.sh && chmod +x docker/sfa_start.sh

# Installing SFA 
RUN cd /root/sfa \
        && make version \
        && python setup.py install --install-scripts=/usr/bin \
        && cd /root/


#Exported volumes (we need an axxcess to those files for other Docker containers, should we share as volumes?)

VOLUME  ["/etc/sfa/root_certificate", "/var/myslice", "/root/docker/", "/var/log/"]

EXPOSE 6080:6080 

ENTRYPOINT ["sh", "/root/docker/sfa_start.sh"]
