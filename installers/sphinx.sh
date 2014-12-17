#!/bin/bash

# Установка
yum install -y http://sphinxsearch.com/files/sphinx-2.2.6-1.rhel7.x86_64.rpm

# Настройка
/bin/cp ../configs/sphinx/sphinx.conf /etc/sphinx/sphinx.conf
