#!/bin/bash
# Contact me if this does not work for you: Radomir Klacza <radomir.klacza@lip6.fr>

# read the options
TEMP=`getopt -o e:p:r: --long email:,password:,root-authority: -n 'registry_init.sh' -- "$@"`
eval set -- "$TEMP"

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
ROOT_AUT=$ROOT_AUTHORITY
ROOT_AUTHORITY+=".myslice"

echo "pass = $ADMIN_PASSWORD"
echo "email = $ADMIN_EMAIL"
echo "auth = $ROOT_AUTHORITY"
echo "root = $ROOT_AUT"

sfaadmin.py reg import_registry
sfaadmin.py reg register -t user -x $ROOT_AUTHORITY -e $ADMIN_EMAIL -k /var/myslice/myslice.pub
sfaadmin.py reg update -t authority -x $ROOT_AUT -p $ROOT_AUTHORITY
mkdir /etc/sfa/root_certificate
cd /etc/sfa/root_certificate
sfaadmin.py cert export onelab

