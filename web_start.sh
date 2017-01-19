# This scripts starts the
FILE=/root/docker/web_initialized

if [ -f $FILE ];
then
   echo "WEB was already initialized, to reinitialize it (experimental), please remove file /root/docker/web_initialized"
   #As deamon 
   /root/myslice/myslice/bin/myslice-live &
   #As deamon 
   /root/myslice/myslice/bin/myslice-monitor &
   # As deamon 
   /root/myslice/myslice/bin/myslice-server &
   #As deamon
   /root/myslice/myslice/bin/myslice-web &

else
   mkdir /var/myslice
   cd /var/myslice
   cp /etc/sfa/root_certificate/myslice.cert /var/myslice/myslice.cert
   cp /etc/sfa/root_certificate/myslice.pkey /var/myslice/myslice.pkey
   echo "bind=all" > /etc/rethinkdb/instances.d/myslice.conf 
   
   #STart 
   /etc/init.d/rethinkdb start
   /root/myslice/bin/db-setup
   
   /root/myslice/init_user.py -e $ADMIN_EMAIL -P $ADMIN_PASSWORD -k /var/myslice/myslice.pkey -p /var/myslice/myslice.pub
   
   /root/myslice/myslice/bin/myslice-live &
   #As deamon 
   /root/myslice/myslice/bin/myslice-monitor &
   # As deamon 
   /root/myslice/myslice/bin/myslice-server &
   #As deamon
   /root/myslice/myslice/bin/myslice-web &
   
   #

fi 

/bin/bash
