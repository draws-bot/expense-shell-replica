#!/bin/bash


set -e

userid=$(id -u)
R="\e[31m"
N="\e[0m"
echo "plz enter your mysql password"
read "password"

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