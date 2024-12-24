#!/bin/bash

source ./ common.sh

set -e


dnf install mysql-server -y

#VALIDATE $?  "INSTALLING MYSQL"

systemctl enable mysqld

#VALIDATE $?  "ENABLE MYSQL"


systemctl start mysqld

#VALIDATE $?  "START MYSQL"

#mysql_secure_installation --set-root-pass ExpenseApp@1

#VALIDATE $?  "SETTING USER AND PASSWORD"

#Below code will be useful for idempotent nature
mysql -h 172.31.26.15 -uroot -p${password} -e 'show databases;'
if [ $? -ne 0 ]
then
     mysql_secure_installation --set-root-pass ${password}
else
    echo  -e "already username and password is set ..$R..SKIPPING $N"
fi
