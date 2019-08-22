# Function to create user and add sftp chroot dir in conf
createUser() 
{
    if ! grep --quiet -E "^${USER}:" /etc/passwd
    then
        PASSWORD=`openssl rand -base64 12`
        DATE=`date`
        echo ""
        echo -e "\xf0\x9f\x96\x96 \033[33mCreate user\033[0m \033[32m${USER}\033[0m"
        echo -e "       \xf0\x9f\x94\x92 \033[33mPassword\033[0m   :  \033[32m${PASSWORD}\033[0m"
        echo ""
        useradd -m -d /var/sftp/${USER} -s /bin/false -g sftp ${USER}
        usermod -p $(openssl passwd -1 "${PASSWORD}") -G sftp ${USER}
        cat <<EOF >> /etc/ssh/sshd_config

########
# Added ${DATE}
########
Match User ${USER}
    ChrootDirectory /var/sftp/${USER}
########
EOF
        service ssh restart
    fi
}