#!/bin/bash

# Установка
yum install -y httpd

# Настройка
mkdir /etc/httpd/vhost.d
cat ../configs/httpd/httpd.conf >> /etc/httpd/conf/httpd.conf
cp ../configs/httpd/expires.conf /etc/httpd/conf.d/

# TODO не смог победить itk, так что пока просто работаем из-под admin
# Настройка httpd-itk
sed -i 's/User apache/User admin/g' /etc/httpd/conf/httpd.conf
sed -i 's/Group apache/Group admin/g' /etc/httpd/conf/httpd.conf
sed -i 's/AssignUserID/#AssignUserID/g' /etc/httpd/conf/httpd.conf
#cp ../configs/httpd/mpm_itk.so /etc/httpd/modules/mpm_itk.so
#sed -i 's/-zts.so/.so/g' /etc/httpd/conf.modules.d/10-php.conf
#sed -i 's/^LoadModule/#LoadModule/g' /etc/httpd/conf.modules.d/00-mpm.conf
#echo 'LoadModule mpm_itk_module modules/mpm_itk.so' >> /etc/httpd/conf.modules.d/00-mpm.conf

# Запуск службы
systemctl start httpd.service
systemctl enable httpd.service

# Firewall
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
