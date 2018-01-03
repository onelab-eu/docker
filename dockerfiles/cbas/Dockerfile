#
# This will install and configure C-BAS
# It needs a database docker linked as db (run --link <your_runnig_cbas_mongodb>:db )
#

FROM ubuntu:16.04
MAINTAINER Loic Baron <loic.baron@lip6.fr>

RUN apt-get update \
	&& apt-get -y install \
				swig \ 
				mongodb \
				python-pip \
				python-dev \
				libffi-dev \
				xmlsec1 \
				git \
				libssl-dev

# Cloning SFA and docker files for sfa configuration
RUN cd /root/ \
	&& git clone git@github.com:loicbaron/C-BAS.git

# Install C-BAS
RUN cd /root/C-BAS \
        && pip install --upgrade pip \
        && pip install -r requirements.txt \
        && cp deploy/config.json.example deploy/config.json \
        && cp deploy/registry.json.example deploy/registry.json \
        && cp deploy/supplimentary_fields.json.onelab deploy/supplimentary_fields.json

# Generate Certificates and Admin user
RUN /bin/bash test/creds/gen-certs.sh $HOSTNAME

# Share root key and certificate generated to volume
VOLUME  ["/var/myslice"]
RUN cp test/creds/root-key.pem /var/myslice/myslice.pkey
RUN cp test/creds/root-cert.pem /var/myslice/myslice.cert
RUN ssh-keygen -y -f /var/myslice/myslice.pkey > /var/myslice/myslice.pub

EXPOSE 8008:8008

# Start C-BAS
ENTRYPOINT /bin/bash cbas.sh start
