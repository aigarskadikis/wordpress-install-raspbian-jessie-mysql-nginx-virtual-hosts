#!/bin/bash

#sudo su
#apt-get update -y && apt-get upgrade -y
#apt-get install git -y
#git clone https://github.com/catonrug/wordpress-install-raspbian-jessie-mysql-nginx-virtual-hosts.git
#cd wordpress-install-raspbian-jessie-mysql-nginx-virtual-hosts
#chmod +x *.sh

#before executing this the first two parts must be installed
#./1-nginx-php-install.sh
#./2-mysql-install-wordpress-database.sh

#now execute
#./wordpress-install-nginx-mysql.sh

#move to virtual host direcotry
cd /var/www/wp.nginx

#remove everything
rm -rf *

#download latest wordpress
wget http://wordpress.org/latest.tar.gz

#extract and remove the archive
tar xzvf latest.tar.gz && rm latest.tar.gz

#move to wordpress direcotry
cd wordpress

#move all content to the parrent direcotry
mv * ..

#move back
cd ..

#remove wordpress dir
rm -rf wordpress

#install adition libraries for wordpress
apt-get install php5-curl php5-gd libssh2-php -y

#to improve php5-fpm performance install cacher
apt-get install php-apc -y

#nginx service is runned by www-data user
#lets allow nginx service to really change the content in wordpress dir
#this will allow us to do the default wordpress wizard using web interface
chown -R www-data:www-data /var/www/wp.nginx

#restart config file for php and nginx
/etc/init.d/php5-fpm reload && /etc/init.d/nginx reload

#everything done
#i can go to http://wp.nginx and folow the wizard
#at first it looks nginx is slower than apache, but after restart it server good

#all credits go to
#https://www.stewright.me/2014/06/tutorial-install-wordpress-on-a-raspberry-pi-using-nginx/