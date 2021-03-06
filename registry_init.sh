#!/bin/bash
# Contact me if this does not work for you: Radomir Klacza <radomir.klacza@lip6.fr>

# read the options
TEMP=`getopt -o e:p:r: --long email:,password:,root-authority: -n 'registry_init.sh' -- "$@"`
eval set -- "$TEMP"

FILE=/root/docker/initialized

if [ -f $FILE ];
then
   echo "SFA was already initialized, to reinitialize it (experimental), please remove file /root/docker/initialized"
else
   echo "Initializing SFA"
    while true ; do
        case "$1" in
            -e|--email)
                case "$2" in
                    "") shift 2 ;;
                    *) ADMIN_EMAIL=$2 ; shift 2 ;;
                esac ;;
            -p|--password)
                case "$2" in
                    "") shift 2 ;;
                    *) ADMIN_PASSWORD=$2 ; shift 2 ;;
                esac ;;
            -r|--root-authority)
                case "$2" in
                    "") shift 2 ;;
                    *) ROOT_AUTHORITY=$2 ; shift 2 ;;
                esac ;;
            --) shift ; break ;;
            *) echo "Internal error!" ; exit 1 ;;
        esac
    done
    ADMIN_USER=$ROOT_AUTHORITY".myslice"

    echo "pass = $ADMIN_PASSWORD"
    echo "email = $ADMIN_EMAIL"
    echo "auth = $ROOT_AUTHORITY"
    echo "admin = $ADMIN_USER"

    sfaadmin.py reg import_registry
    sfaadmin.py reg register -t user -x $ADMIN_USER -e $ADMIN_EMAIL -k /var/myslice/myslice.pub
    sfaadmin.py reg update -t authority -x $ROOT_AUTHORITY -p $ADMIN_USER
    mkdir /etc/sfa/root_certificate
    cd /etc/sfa/root_certificate
    sfaadmin.py cert export $ADMIN_USER -o myslice.cert
    sfaadmin.py cert export $ROOT_AUTHORITY
    cp /var/myslice/myslice myslice.pkey
    touch /root/docker/initialized
    echo "SFA was already initialized, to reinitialize it, pls remove this file" > /root/docker/initialized
fi

