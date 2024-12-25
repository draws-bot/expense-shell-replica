#!/bin/bash


source ./common.sh

check_root

echo "plz enter your mysql password"
read mysql_root_password


dnf module disable nodejs -y
#VALIDATE $? "disable nodejs"

dnf module enable nodejs:20 -y
#VALIDATE $? "enable nodejs"


dnf install nodejs -y
#VALIDATE $? "install nodejs"

id expense
if [ $? -ne 0 ]
then
    useradd expense 
#    VALIDATE $?  "creating username"
else 
    echo "already expense username is created"
fi

mkdir -p /app
#VALIDATE $?  "creating app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip

#VALIDATE $?  "downloading frontend files"


cd /app
rm -rf /app/*
unzip /tmp/backend.zip
#VALIDATE $?  "unzip backend.zip"

cd /app
npm install
#VALIDATE $?  "npm install succesfull"

cp /home/ec2-user/expense-document/backend.service     /etc/systemd/system/backend.service                                                   


systemctl daemon-reload
#VALIDATE $?  "daemon-realod"

systemctl start backend
#VALIDATE $?  "start backend"


systemctl enable backend

#VALIDATE $?  "enable backend"


dnf install mysql -y

#VALIDATE $?  "mysql install"


mysql -h 172.31.28.68 -uroot -p${mysql_root_password} < /app/schema/backend.sql

#VALIDATE $?  "schema is loading"


systemctl restart backend

#VALIDATE $?  "restart backend"
