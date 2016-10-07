# This script is to start SFA services 

#As deamon 
/usr/bin/sfa-start.py -t -d
#As deamon 
/usr/bin/sfa-start.py -r -d 
# As deamon 
/usr/bin/sfa-start.py -a -d
# Read log
tail -f /var/log/sfa.log

