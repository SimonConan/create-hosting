# Function to create user
createUser() 
{
    if ! grep --quiet -E "^${USER}:" /etc/passwd
    then
        echo ""
        echo -e "\xf0\x9f\x96\x96 \033[33mCreate user\033[0m \033[32m${USER}\033[0m"
        PASSWORD=`openssl rand -base64 12`
        echo -e "       \xf0\x9f\x94\x92 \033[33mPassword\033[0m   :  \033[32m${PASSWORD}\033[0m"
        echo ""
        useradd -m -d /var/sftp/${USER} -g sftp -s /bin/false $USER
        echo -e "${PASSWORD}" | passwd ${USER}
        chown -R ${USER}:sftp /var/sftp/users/${USER}/live
        chown -R 700 /var/sftp/users/${USER}/live
    fi
}