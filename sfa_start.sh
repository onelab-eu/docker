# This script is to start SFA services 

#As deamon 
/usr/bin/sfa-start.py -t -d
#As deamon 
/usr/bin/sfa-start.py -r -d 
# As deamon 
/usr/bin/sfa-start.py -a -d
# Read log

FILE=/root/docker/initialized

if [ -f $FILE ];
then
   echo "SFA was already initialized, to reinitialize it (experimental), please remove file /root/docker/initialized"
else
   sh /root/docker/registry_init.sh -e $ADMIN_EMAIL -p $ADMIN_PASSWORD -r $ROOT_AUTHORITY
   killall5 -9 sfa-start.py
   /usr/bin/sfa-start.py -t -d
   /usr/bin/sfa-start.py -r -d 
   /usr/bin/sfa-start.py -a -d
fi 

tail -f /var/log/sfa.log

