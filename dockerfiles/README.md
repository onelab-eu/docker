# Populating Docker images 

## On Ubuntu 14.04:

Generally it is very simple, however there are some important remarks in the scripts below (like sharing volumes between containers), so please read carefully, or just copy/paste. 

IMPORTANT: It is strongly recommended to install them for developement purposes only. If you want to run your service on production environment you should deploy and configure it manually on VM or adjust provided docker files.

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
You can check by connecting to PSQL DB:
```bash
psql -p <port_number> -h localhost -U docker sfa # replace <port_number> with one returned by docker ps command
``` 

Build second container:
```bash
cd ~/docker/dockerfiles/sfa_reg
docker build -t myslice/sfa_reg:latest .
```


To run this docker you need to set 3 environmental variables that will be used in a script to configure your myslice copy:
$ROOT_AUTHORITY - [a-z] only! No special chars, nod dots, no spaces, no dash etc. are allowed. I.e.: myorganizationname
$ADMIN_EMAIL 
$ADMIN_PASSWORD 
Script will automatically set ADMIN_USER as $ROOT_AUTHORITY+".myslice" 

```bash
docker run --name sfa_reg --link sfa_reg_pg:db -p 6080:6080 -d -e "ADMIN_EMAIL=fake@fake.com" -e "ROOT_AUTHORITY=myorganizationname" -e "ADMIN_PASSWORD=test12345"  myslice/sfa_reg 
```
During first run DB will be popluated automaticaly

Next we can start to build web_myslice 
```bash 
cd /root/docker/dockerfiles/web_myslice
```
Configure endpoints for testbeds, email settings and hrn in init_script.py. For hrm replace:

hrn = "onelab.myslice" with the same value that you set for $ROOT_AUTHORITY (in our example myorganizationname) adding .myslice:
```bash 
hrn = "myorganizationname.myslice"
```

Than you are ready to build web_myslice:
```bash 
docker build -t myslice/sfa_reg:latest .
```
And run it with the same ADMIN_EMAIL and ADMIN_PASSWORD like you did while running sfa_reg 
```bash 
 docker run --name web_myslice --link sfa_reg:sfa_reg --volumes-from sfa_reg -p 8111:8111 -p 8080:8080 -p 28015:28015 -e "ADMIN_EMAIL=fake@fake.com" -e "ADMIN_PASSWORD=test12345" -t -i myslice/web_myslice
 ```
And you are done! To connect web interface use IP of the docker host and port 8080 for WEB interface, 8111 for rethinkdb interface and 28015 for rethink API.
If you would like to connect any docker image:
```bash 
docker exec -it <name_of_image> bash
```
