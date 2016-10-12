# Populating Docker images 

## On Ubuntu 14.04:


```bash
sudo su -
apt-get update && apt-get -y upgrade
apt-get -y install docker.io git
git clone https://github.com/onelab-eu/docker.git
```
Build first image:
```bash
cd /root/docker/dockerfiles/sfa_reg_pg
docker build -t myslice/sfa_reg_pg:latest .

docker ps
REPOSITORY           TAG                 IMAGE ID            CREATED              VIRTUAL SIZE
myslice/sfa_reg_pg   latest              02611e2e3276        About a minute ago   313 MB
```
Run it:
``` bash
docker run -P -d --name sfa_reg_pg myslice/sfa_reg_pg
``` 
