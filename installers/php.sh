#!/bin/bash


# Установка
yum install -y php55w php55w-common php55w-cli php55w-opcache php55w-gd php55w-xml php55w-intl php55w-mbstring php55w-mcrypt php55w-pdo php55w-mysql php55w-pgsql

# Настройка
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 100M/g' /etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g' /etc/php.ini
sed -i 's/;date.timezone =/date.timezone = Europe\/Moscow/g' /etc/php.ini
#sed -i 's/;session.save_path = "/tmp"/session.save_path = "/var/lib/php/session"/g' /etc/php.ini

chmod -R 777 /var/lib/php/session/

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer.phar
