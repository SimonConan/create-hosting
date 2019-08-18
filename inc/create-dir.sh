# Function to create directory for user and add sftp chroot dir in conf
createDir()
{
    if [ ! -d /var/sftp/${USER} ]
    then
    echo ""
    echo -e "\xf0\x9f\xa4\x98 \033[33mCreate\033[0m \033[32m/var/sftp/${USER}/live\033[0m"
    echo ""
    mkdir /var/sftp/${USER}
    mkdir /var/sftp/${USER}/live
    cat <<EOF > /etc/ssh/sshd_config
Match user ${USER}
    ChrootDirectory /var/sftp/${USER}/
EOF
    fi
}