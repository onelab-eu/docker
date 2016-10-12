# This script is to start SFA services 

FILE=/root/docker/initialized

if [ -f $FILE ];
then
   echo "SFA was already initialized, to reinitialize it (experimental), please remove file /root/docker/initialized"
   #As deamon 
   /usr/bin/sfa-start.py -t -d
   #As deamon 
   /usr/bin/sfa-start.py -r -d 
   # As deamon 
   /usr/bin/sfa-start.py -a -d

else
   cp /root/docker/registry.sfa_config /etc/sfa/sfa_config
   sed -i "s/root_auth=onelab/root_auth=$ROOT_AUTHORITY/g" /etc/sfa/sfa_config
   sed -i "s/interface_hrn=onelab/interface_hrn=$ROOT_AUTHORITY/g" /etc/sfa/sfa_config 
   mkdir /var/myslice/
   ssh-keygen -f /var/myslice/myslice -t rsa -N ''
   #As deamon 
   /usr/bin/sfa-start.py -t -d
   #As deamon 
   /usr/bin/sfa-start.py -r -d 
   # As deamon 
   /usr/bin/sfa-start.py -a -d
   
   sh /root/docker/registry_init.sh -e $ADMIN_EMAIL -p $ADMIN_PASSWORD -r $ROOT_AUTHORITY
   killall5 -9 sfa-start.py
   /usr/bin/sfa-start.py -t -d
   /usr/bin/sfa-start.py -r -d 
   /usr/bin/sfa-start.py -a -d
fi 

tail -f /var/log/sfa.log

