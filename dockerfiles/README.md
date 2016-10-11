# Populating Docker images 

## On Ubuntu 14.04:


```bash
sudo su -
apt-get update && apt-get -y upgrade
apt-get -y install docker.io git
git clone https://github.com/onelab-eu/docker.git
cd /root/docker/dockerfiles/sfa_reg_pg
docker build -t myslice/sfa_reg_pg:latest .
```
Now you should have your first image built:

```bash
docker ps
REPOSITORY           TAG                 IMAGE ID            CREATED              VIRTUAL SIZE
myslice/sfa_reg_pg   latest              02611e2e3276        About a minute ago   313 MB
```
Run it:
``` bash
docker run -P -d --name sfa_reg_pg myslice/sfa_reg_pg
``` 
Check if it is running: 
```bash
docker ps 
CONTAINER ID        IMAGE                       COMMAND                CREATED             STATUS              PORTS                     NAMES
9bbbcaa23066        myslice/sfa_reg_pg:latest   "/usr/lib/postgresql   14 seconds ago      Up 12 seconds       0.0.0.0:32768->5432/tcp   sfa_reg_pg 
```
