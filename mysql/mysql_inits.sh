#!/bin/bash 

chown -R mysql:mysql /var/lib/mysql
mysql_install_db --user mysql > /dev/null

DAEMON=/usr/sbin/mysqld
#chown -R mysql:mysql /var/lib/mysql
#chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
#&& chmod 777 /var/run/mysqld

PID=$(jobs -p)
trap "kill -SIGQUIT $PID" EXIT 

sleep 3

MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"toor"}

tfile=`mktemp`
if [[ ! -f "$tfile" ]]; then
	return 1
    fi


cat << EOF > $tfile 
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("$MYSQL_ROOT_PASSWORD") WHERE user='root';
FLUSH PRIVILEGES;
EOF

/usr/sbin/mysqld --bootstrap --verbose=0 $MYSQLD_ARGS < $tfile
rm -f $tfile

#chown -R mysql:mysql /var/lib/mysql/* /var/run/mysqld \
#&& chmod 777 /var/run/mysqld 


$DAEMON & 
PID=$(jobs -p)
trap "kill -SIGQUIT $PID" INT
wait
