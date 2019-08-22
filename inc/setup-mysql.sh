# Function to create a mysql user and a database for the projet
setupMysql()
{
    source ${PWD}/.env
    if [ ${MYSQL_ROOT_PASSWORD} != "" ]
    then
 
        SQLPASS=`openssl rand -base64 12`
        SQLPASS="${SQLPASS}!"

        Q1="CREATE DATABASE IF NOT EXISTS ${DOMAIN};"
        Q2="GRANT ALL ON ${DOMAIN}.* TO '${USER}'@'%' IDENTIFIED BY '${SQLPASS}';"
        Q3="FLUSH PRIVILEGES;"
        SQL="${Q1}${Q2}${Q3}"

        echo ""
        echo -e "\xf0\x9f\x8c\x8e \033[33mCreate MYSQL DB and user\033[0m"
        echo -e "       \xf0\x9f\x94\x92 \033[33mPassword\033[0m   :  \033[32m${SQLPASS}\033[0m"
        echo ""
        export MYSQL_PWD=${MYSQL_ROOT_PASSWORD}
        mysql -uroot -e "${SQL}"
    fi
}