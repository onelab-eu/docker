sfaadmin.py reg import_registry
sfaadmin.py reg register -t user -x onelab.myslice -e support@myslice.info -k /var/myslice/myslice.pub
sfaadmin.py reg update -t authority -x onelab -p onelab.myslice
mkdir /etc/sfa/root_certificate
cd /etc/sfa/root_certificate
sfaadmin.py cert export onelab
