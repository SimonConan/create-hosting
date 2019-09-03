# Function to add the current version of Wordpress
del()
{
  source ${PWD}/.env
  if [ ${MYSQL_ROOT_PASSWORD} != "" ]
  then
    ## 
    # MYSQL
    ##
    export MYSQL_PWD=${MYSQL_ROOT_PASSWORD}
    echo ""
    echo -e "\033[33mMYSQL\033[0m"
    ## Drop database
    echo -e "       \033[33mDrop Database\033[0m"
    REQ_DAT="DROP DATABASE ${USER};"
    mysql -uroot -e "${REQ_DAT}"
    ## Drop user
    echo -e "       \033[33mDrop User\033[0m"
    REQ_USER="DROP USER ${USER}@'%';"
    mysql -uroot -e "${REQ_USER}"

    ## 
    # APACHE
    ##
    echo ""
    echo -e "\033[33mAPACHE\033[0m"
    ## Disable site
    echo -e "       \033[33mDisable site\033[0m"
    a2dissite ${DOMAIN}.conf
    ## Delete site conf
    echo -e "       \033[33mDelete site conf\033[0m"
    if [ -f /etc/apache2/sites-available/${DOMAIN}.conf ]
    then
      rm /etc/apache2/sites-available/${DOMAIN}.conf
    fi
    if [ -f /etc/apache2/sites-available/${DOMAIN}-le-ssl.conf ]
    then
      rm /etc/apache2/sites-available/${DOMAIN}-le-ssl.conf
    fi
    ## Reload apache
    systemctl restart apache2

    ## 
    # USER
    ##
    echo ""
    echo -e "\033[33mUSER\033[0m"
    ## Drop database
    echo -e "       \033[33mUser delete\033[0m"
    userdel -r ${USER}
    ## Remove dir
    echo -e "       \033[33mDelete dir\033[0m"
    rm -rf /var/www/live/${DOMAIN}
    rm -rf /var/sftp/${USER}
  fi
}