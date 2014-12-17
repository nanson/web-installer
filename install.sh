#!/bin/bash

# Первоначальная настройка
./config.sh

# PHP
./installers/php.sh

# Apache
./installers/httpd.sh

# MySql
./installers/mysql.sh

# PostgreSql
./installers/postgresql.sh

# Sphinx
./installers/sphinx.sh
