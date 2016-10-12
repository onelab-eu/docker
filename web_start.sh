# This scripts starts the
FILE=/root/docker/web_initialized

if [ -f $FILE ];
then
   echo "WEB was already initialized, to reinitialize it (experimental), please remove file /root/docker/web_initialized"
   #As deamon 
   /home/radomir/myslice/myslice/bin/myslice-live &
   #As deamon 
   /home/radomir/myslice/myslice/bin/myslice-monitor &
   # As deamon 
   /home/radomir/myslice/myslice/bin/myslice-server &
   #As deamon
   /home/radomir/myslice/myslice/bin/myslice-web &

else
   cd /var/myslice
   cp /etc/sfa/root_certificate/myslice.cert myslice.cert
   cp /etc/sfa/root_certificate/myslice.pkey myslice.pkey
   echo "bind=all" > /etc/rethinkdb/instances.d/myslice.conf 
   #STart 
   /etc/init.d/rethinkdb start
   /home/radomir/myslice/myslice/bin/myslice-live &
   #As deamon 
   /home/radomir/myslice/myslice/bin/myslice-monitor &
   # As deamon 
   /home/radomir/myslice/myslice/bin/myslice-server &
   #As deamon
   /home/radomir/myslice/myslice/bin/myslice-web &

fi 

/bin/bash
