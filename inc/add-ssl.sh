# Function to add a ssl certificate
addSsl() 
{
    if [ -f /etc/apache2/sites-enabled/${DOMAIN}.conf ]
    then
        echo ""
        echo -e "\xf0\x9f\x96\x96 \033[33mActivate ssl certificate\033[0m"
        echo ""
        certbot --authenticator webroot --webroot-path /var/www/live/${DOMAIN} --installer apache -d ${DOMAIN}
        systemctl restart apache2
    fi
}