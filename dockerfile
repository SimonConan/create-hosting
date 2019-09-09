## Standard image apache / php ##
##
#
# setupMysql will not work because mysql client not installed
# addSSL will not work because real DN is not pointing to the webserver
# in addWP the DB info used won't be good
#
##

# start from base
FROM ubuntu:18.04
LABEL maintainer="Simon Conan : <simonconan@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -yqq update
RUN apt-get -yqq install \
        openssh-server \
        mailutils \
        apache2 \
        php \
        php-mysql \ 
        libapache2-mod-php

# setup apache conf
RUN rm /etc/apache2/sites-enabled/000-default.conf
RUN a2enmod authz_core proxy_fcgi ssl rewrite proxy proxy_balancer proxy_http proxy_ajp 

# create mandatory dir for the script to work
RUN mkdir /var/sftp

# ports exposed
EXPOSE 80
EXPOSE 443

# run command
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

## End Standard image apache / php ##