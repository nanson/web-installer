#!/bin/bash

# Установка
yum install -y postgresql93-server
/usr/pgsql-9.3/bin/postgresql93-setup initdb

# Запуск службы
systemctl enable postgresql-9.3.service
systemctl start postgresql-9.3.service

# Установка пароля для postgres
echo 'Установка пароля СУБД PostgreSql для пользователя postgres'
sudo -u postgres psql -c '\password postgres '

# Настройка авторизации
sed -i 's/host    all             all             127.0.0.1\/32            ident/host    all             all             0.0.0.0\/0            password/g' /var/lib/pgsql/9.3/data/pg_hba.conf
sed -i 's/host    all             all             ::1\/128                 ident/host    all             all             ::1\/128              password/g' /var/lib/pgsql/9.3/data/pg_hba.conf

# Удаленный доступ
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/9.3/data/postgresql.conf
firewall-cmd --permanent --add-port=5432/tcp
firewall-cmd --reload

systemctl restart postgresql-9.3.service
