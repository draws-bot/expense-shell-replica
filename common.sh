#!/bin/bash


set -e

userid=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
R="\e[31m"
N="\e[0m"


VALIDATE(){
    if [ $1 -ne 0 ]
    then
    echo "$2 IS ....FAILURE"
    exit 1
    else
    echo "$2 is .....success"
    fi
}

check_root(){
if [ $userid -ne 0 ]
then
    echo "you are not in super user:"
    exit 1
else
    echo "you are at super user"
fi
}