#!/bin/bash

service nginx start
service php7.3-fpm start
service mysql start
echo "create database wordpress;" | mysql
echo "CREATE USER 'truby'@'localhost' IDENTIFIED BY '123';" | mysql
echo "GRANT ALL ON wordpress.* TO 'truby'@'localhost' IDENTIFIED BY '123' WITH GRANT OPTION;" | mysql
echo "flush privileges;" | mysql

bash