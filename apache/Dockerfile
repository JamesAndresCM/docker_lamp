#Debian apache

#Origen debian jessie
FROM debian

MAINTAINER Nameless "duolon2014@gmail.com"

ENV DEBIAN_FRONTEND noninteractive 


RUN apt-get update && apt-get install -y apache2 php5 libapache2-mod-php5 \ 
php5-mysqlnd php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap phpmyadmin vim \
php5-mcrypt php5-memcache php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "ServerName debian" >> /etc/apache2/apache2.conf
RUN echo "<?php phpinfo(); ?>" > /var/www/html/info.php
RUN a2enmod rewrite
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
RUN echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
RUN sed -i 's/'table_uiprefs'/'pma__table_uiprefs'/' /etc/phpmyadmin/config.inc.php
RUN sed -i 's/'recent'/'pma__recent'/' /etc/phpmyadmin/config.inc.php
RUN sed -i 's/$dbuser/'"''"'/' /etc/phpmyadmin/config.inc.php
RUN sed -i 's/$dbpass/'"''"'/' /etc/phpmyadmin/config.inc.php
RUN sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/' /etc/php5/apache2/php.ini
RUN echo '$cfg['"'Servers'"'][$i]['"'host'"'] = '"'debdatabase'"';' >> /etc/phpmyadmin/config.inc.php


WORKDIR /data
COPY data/ .
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

