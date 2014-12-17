#!/bin/bash

# Установка
yum install -y mariadb-server mariadb

# Запуск службы
systemctl start mariadb.service
systemctl enable mariadb.service

# Удаленный доступ
mysql -uroot -e "USE mysql; UPDATE \`user\` SET \`Host\` = '%' WHERE \`Host\` = '$(uname -n)' AND \`User\` = 'root';"
firewall-cmd --permanent --zone=public --add-service=mysql
firewall-cmd --reload

# Настройка
mysql_secure_installation
/bin/cp ../configs/my.cnf.d/server.cnf /etc/my.cnf.d/server.cnf
systemctl restart mariadb.service
