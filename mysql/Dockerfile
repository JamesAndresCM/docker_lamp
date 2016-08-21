#Debian myslq

#Origen debian jessie
FROM debian

MAINTAINER Nameless "duolon2014@gmail.com"

ENV DEBIAN_FRONTEND noninteractive 

RUN apt-get update && apt-get install -y mysql-server \ 
&& apt-get clean && rm -rf /var/lib/apt/lists/* 

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
RUN sed -i "s/key_buffer/key_buffer_size/" /etc/mysql/my.cnf
RUN sed -i "s/myisam-recover/myisam-recover-options/" /etc/mysql/my.cnf

ADD mysql_inits.sh /opt/mysql_inits.sh

CMD ["/bin/bash", "/opt/mysql_inits.sh"]

