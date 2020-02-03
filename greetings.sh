#!/bin/bash
time=$(date +%H)
if [ $time -lt 12 ];then
    msg="Good Morning $USER"
elif [ $time -gt 12 -a $time -lt 18 ];then 
    msg="Good Afternoon $USER"
else 
    msg="Good Night $USER"
fi
echo "当前时间是：$(date +"%Y-%m-%d %H:%M:%S")"
echo -e "\033[34m$msg\033[0m"
