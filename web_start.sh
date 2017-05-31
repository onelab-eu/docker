# This scripts starts the
FILE=/root/docker/web_initialized

if [ -f $FILE ];
then
   echo "WEB was already initialized, to reinitialize it (experimental), please remove file /root/docker/web_initialized"
   sh /root/myslice/myslice/start.sh
    
else
   mkdir /var/myslice
   cd /var/myslice
   cp /etc/sfa/root_certificate/myslice.cert /var/myslice/myslice.cert
   cp /etc/sfa/root_certificate/myslice.pkey /var/myslice/myslice.pkey
   echo "bind=all" > /etc/rethinkdb/instances.d/myslice.conf 
   
   #STart 
   /etc/init.d/rethinkdb start
   /root/myslice/myslice/bin/db-setup &
   
   /root/myslice/init_user.py -e $ADMIN_EMAIL -P $ADMIN_PASSWORD -k /var/myslice/myslice.pkey -p /var/myslice/myslice.pub
   
   sh /root/myslice/start.sh
   
   #

fi 

/bin/bash
