# Function to create a vhost for the project
createVhost() 
{
    if [ ! -f /etc/apache2/sites-available/${DOMAIN}.conf ]
    then        
        echo ""
        echo -e "\xf0\x9f\x93\xb0 \033[33mCreate vhost for\033[0m \033[32m${DOMAIN}\033[0m"
        echo ""
        cat <<EOF > /etc/apache2/sites-available/${DOMAIN}.conf
<VirtualHost *:80>
    ServerName ${DOMAIN}
    ServerAdmin webmaster@${DOMAIN}

    Errorlog /var/log/apache2/${DOMAIN}_error.log
    CustomLog /var/log/apache2/${DOMAIN}_access.log combined

    DocumentRoot /var/www/live/${DOMAIN}

    <IfModule mod_rewrite.c>
        RewriteEngine On
    </IfModule>
</VirtualHost>
EOF
        a2ensite ${DOMAIN}.conf
        systemctl restart apache2

    fi
}