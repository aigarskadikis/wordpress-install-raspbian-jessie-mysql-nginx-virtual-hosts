#!/bin/bash
#this is tested on fresh 2016-09-23-raspbian-jessie-lite.img
#sudo su
#apt-get update -y && apt-get upgrade -y && apt-get install git -y
#git clone https://github.com/catonrug/wordpress-install-raspbian-jessie-mysql-nginx-virtual-hosts.git && cd wordpress-install-raspbian-jessie-mysql-nginx-virtual-hosts && chmod +x *.sh
#./2-mysql-install-wordpress-database.sh

#install mysql-server. the password for root account I set 'password'. very secure. I know :)
apt-get install mysql-server -y
#this will automatically install additional packages such as: libaio1 libdbd-mysql-perl libdbi-perl libhtml-template-perl libmysqlclient18 libterm-readkey-perl mysql-client-5.5 mysql-common mysql-server mysql-server-5.5 mysql-server-core-5.5

apt-get install mysql-client php5-mysql -y
#note that mysql-client is not the same as mysql-client-5.5
#this will do some merging with preinstalled php-fpm

#create database 'wpdb'
mysql -uroot -ppassword <<< 'CREATE DATABASE wpdb;'

#create new user 'wpuser' with password 'HAL3jpz4v7xzvGLZ'
mysql -uroot -ppassword <<< 'CREATE USER "wpuser"@"localhost" IDENTIFIED BY "HAL3jpz4v7xzvGLZ";'

#let the user 'wpuser' manage all content for database 'wpdb'
mysql -uroot -ppassword <<< 'GRANT ALL PRIVILEGES ON wpdb.* TO "wpuser"@"localhost";'

#to browse wordpress database from different location use something like
mysql -uroot -ppassword <<< 'GRANT ALL PRIVILEGES ON wpdb.* TO "wpuser"@"192.168.99.254";'

#let the new permissions goes on production
mysql -uroot -ppassword <<< 'FLUSH PRIVILEGES;'

#test if I can really use this new user 'wpuser' together with password 'HAL3jpz4v7xzvGLZ'
mysql -uwpuser -pHAL3jpz4v7xzvGLZ <<< 'SHOW DATABASES;'

#all credits go to
#https://www.stewright.me/2014/06/tutorial-install-mysql-server-on-raspberry-pi/
