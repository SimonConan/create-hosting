#!/bin/bash

if [[ $EUID -ne 0 ]]; 
then
    echo ""
    echo -e "\033[33mThis script must be run as root\033[0m"
    exit 1
fi

PWD=`pwd`

if [ ! -f ${PWD}/.env ]
then
    echo ""
    echo -e "\033[33m.env file not found\033[0m"
    exit 1
fi

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
    echo -e  " \033[32m--setup-mysql\033[0m"
    echo -e  "      \033[32mCreate a mysql user and a database for the projet\033[0m"
    echo -e  " \033[32m--add-wp\033[0m"
    echo -e  "      \033[32mAdd WP sources\033[0m"
    echo -e  " \033[32m--create-vhost\033[0m"
    echo -e  "      \033[32mCreate Apache vhost for the project\033[0m"
    echo -e  " \033[32m--add-ssl\033[0m"
    echo -e  "      \033[32mAdd a ssl certificate\033[0m"
    echo -e  " \033[32m--del\033[0m"
    echo -e  "      \033[32mDelete a user and all dir\033[0m"
    echo ""
    echo -e "\033[33mHelp:\033[0m"
    echo " Create hosting for test.fr and creation of a user test"
    echo -e " \033[32m$0 test.fr testuser\033[0m"
    exit 1
fi

DOMAIN=$1
USER=$2
ARG="false"

for i in $@
do
    if [[ $i == --* ]]
    then
        case $i in
            --all)
                source ${PWD}/inc/create-dir.sh
                source ${PWD}/inc/create-user.sh
                source ${PWD}/inc/setup-mysql.sh
                source ${PWD}/inc/add-wp.sh
                source ${PWD}/inc/create-vhost.sh
                source ${PWD}/inc/add-ssl.sh
                createUser
                createDir
                setupMysql
                addWP
                createVhost
                addSsl
                exit 1;;
            --create-dir)
                source ${PWD}/inc/create-dir.sh
                createDir
                ARG="true";;
            --create-user)
                source ${PWD}/inc/create-user.sh
                createUser
                ARG="true";;
            --add-wp)
                source ${PWD}/inc/add-wp.sh
                addWP
                ARG="true";;
            --setup-mysql)
                source ${PWD}/inc/setup-mysql.sh
                setupMysql
                ARG="true";;
            --create-vhost)
                source ${PWD}/inc/create-vhost.sh
                createVhost
                ARG="true";;
            --add-ssl)
                source ${PWD}/inc/add-ssl.sh
                addSsl
                ARG="true";;
            --del)
                source ${PWD}/inc/del.sh
                del
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
    echo -e  " \033[32m--setup-mysql\033[0m"
    echo -e  "      \033[32mCreate a mysql user and a database for the projet\033[0m"
    echo -e  " \033[32m--add-wp\033[0m"
    echo -e  "      \033[32mAdd WP sources\033[0m"
    echo -e  " \033[32m--create-vhost\033[0m"
    echo -e  "      \033[32mCreate Apache vhost for the project\033[0m"
    echo -e  " \033[32m--add-ssl\033[0m"
    echo -e  "      \033[32mAdd a ssl certificate\033[0m"
    echo -e  " \033[32m--del\033[0m"
    echo -e  "      \033[32mDelete a user and all dir\033[0m"
    echo ""
fi