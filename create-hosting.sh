#!/bin/bash

if [[ -z "$3" ]] || [[ $1 == --* ]] || [[ $2 == --* ]]
then
    echo ""
    echo -e "\033[33mUsage:\033[0m"
    echo " $0 <domain> <user> "
    echo ""
    echo -e "\033[33mArguments (at least one is mandatory):\033[0m"
    echo -e  " \033[32m--all\033[0m"
    echo -e  "      \033[32mAll actions (createDir, createUser)\033[0m"
    echo -e  " \033[32m--create-dir\033[0m"
    echo -e  "      \033[32mCreate directory for user and add sftp chroot dir in conf\033[0m"
    echo -e  " \033[32m--create-user\033[0m"
    echo -e  "      \033[32mCreate SFTP user\033[0m"
    echo ""
    echo -e "\033[33mHelp:\033[0m"
    echo " Create hosting for test.fr and creation of a user test"
    echo -e " \033[32m$0 test.fr testuser\033[0m"
    exit 1
fi

# if [[ $EUID -ne 0 ]]; 
# then
#     echo ""
#     echo -e "\033[33mThis script must be run as root\033[0m"
#     exit 1
# fi

DOMAIN=$1
USER=$2
ARG="false"

for i in $@
do
    if [[ $i == --* ]]
    then
        case $i in
            --all)
                source ./inc/create-dir.sh
                source ./inc/create-user.sh
                createDir
                createUser
                exit 1;;
            --create-dir)
                source ./inc/create-dir.sh
                createDir
                ARG="true";;
            --create-user)
                source ./inc/create-user.sh
                createUser
                ARG="true";;
            *)
                echo ""
                echo -e " \033[32m$0 Unknown arguments: \033[0m" $i;;
        esac        
    fi
done

if [ ${ARG} == "false" ]
then
    echo ""
    echo -e "\033[33mArguments (at least one is mandatory):\033[0m"
    echo -e  " \033[32m--all\033[0m"
    echo -e  "      \033[32mAll actions (createDir, createUser)\033[0m"
    echo -e  " \033[32m--create-dir\033[0m"
    echo -e  "      \033[32mCreate directory for user and add sftp chroot dir in conf\033[0m"
    echo -e  " \033[32m--create-user\033[0m"
    echo -e  "      \033[32mCreate SFTP user\033[0m"
    echo ""
fi

# if [ ! -f /etc/apache2/sites-available/${REFERENCEDOMAIN}.conf ]
# then
    # echo "# ${REFERENCEDOMAIN}" > /etc/apache2/sites-available/${REFERENCEDOMAIN}.conf
    # cat <<EOF> /etc/apache2/sites-available/${REFERENCEDOMAIN}.conf
# <VirtualHost *:8000>
    # ServerName ${REFERENCEDOMAIN}
    # ServerAdmin webmaster@${REFERENCEDOMAIN}
    # CustomLog /var/log/apache2/${REFERENCEDOMAIN}.log combined
    # CustomLog /var/log/apache2/access.log vhost_combined
    # DocumentRoot /var/www/vhosts/${REFERENCEDOMAIN}/current/site
    # <IfModule mod_vhost_alias.c>
        # ServerAlias ${ALIASDOMAIN}
        # VirtualDocumentRoot /var/www/vhosts/%0/current/site
    # </IfModule>
    # <IfModule mod_proxy.c>
        # SetEnv proxy-sendcl 1
        # ProxyPreserveHost On
        # AllowEncodedSlashes On
        # ProxyRequests Off
        # ProxyTimeout 300
        # <Proxy *>
            # Options +Includes
            # AddDefaultCharset off
        # </Proxy>
    # </IfModule>
    # <IfModule mod_php.c>
        # php_admin_flag engine Off
        # php_admin_value open_basedir "/etc/php:/usr/share/php:/tmp:/var/tmp:/var/lib/php:/var/www/vhosts/"
    # </IfModule>
    # <IfModule mod_rewrite.c>
        # RewriteEngine On
    # </IfModule>
    # <IfModule mpm_itk_module>
        # AssignUserId ${USER}-${ENVIRON}web ${USER}-${ENVIRON}
    # </IfModule>
# </VirtualHost>
    # EOF
# service apache2 reload
# fi