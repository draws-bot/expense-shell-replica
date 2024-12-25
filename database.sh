#!/bin/bash

source ./common.sh

check_root

echo "plz enter your mysql password"
read mysql_root_password


dnf install mysql-server -y &>>$LOGFILE

#VALIDATE $?  "INSTALLING MYSQL"

systemctl enable mysqld &>>$LOGFILE

#VALIDATE $?  "ENABLE MYSQL"


systemctl start mysqld &>>$LOGFILE

#VALIDATE $?  "START MYSQL"

#mysql_secure_installation --set-root-pass ExpenseApp@1

#VALIDATE $?  "SETTING USER AND PASSWORD"

#Below code will be useful for idempotent nature
mysql -h 172.31.27.108 -uroot -p${mysql_root_password} -e 'show databases;'
if [ $? -ne 0 ]
then
     mysql_secure_installation --set-root-pass ${mysql_root_password}
     echo "root password set up done "
else
    echo  -e "already username and password is set ..$R..SKIPPING $N"
fi


