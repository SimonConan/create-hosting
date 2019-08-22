# Function to add the current version of Wordpress
addWP()
{
    if [ ! -f /var/sftp/${USER}/live/wp-config.php ]
    then
        echo ""
        echo -e "\xf0\x9f\x8c\x8e \033[33mAdd WP sources\033[0m"
        echo ""
        wp core download --path="/var/sftp/${USER}/live/" --locale="fr_FR" --allow-root
        chown -R ${USER}:sftp /var/sftp/${USER}/live
        chmod -R 755 /var/sftp/${USER}/live
        find /var/sftp/${USER}/live/ -type d -exec chmod 755 {} \;
        find /var/sftp/${USER}/live/ -type f -exec chmod 744 {} \;
        # chown -R :www-data /var/sftp/${USER}/live/wp-content/uploads
        # chmod -R 775 /var/sftp/${USER}/live/wp-content/uploads
    fi
}