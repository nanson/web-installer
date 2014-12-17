#!/bin/bash

# Отключение Selinux
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# Обновление
yum update -y
yum -y install patch

#
# Подключение дополнительных репозиториев
#

# Epel
rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
# Webtatic
rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
# PostgreSql
patch -R /etc/yum.repos.d/CentOS-Base.repo ./conf/yum.repos.d/CentOS-Base.repo.diff
rpm -Uvh http://yum.postgresql.org/9.3/redhat/rhel-7-x86_64/pgdg-centos93-9.3-1.noarch.rpm

# Установка основных утилит
yum update -y
yum install -y net-tools mc htop wget curl git

#Добаление пользователя admin
useradd admin
passwd admin
mkdir /home/admin/logs
mkdir /home/admin/sites
cp -R ./conf/httpd/localhost /home/admin/sites/
chown -R admin:admin /home/admin/
