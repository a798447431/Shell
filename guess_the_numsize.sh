#!/bin/bash 
#RANDOM是系统自带的系统变量，值为0-32767的随机数
num=$[RANDOM%100+1]
echo "$num"

while true
do
    read -p "计算机生成了一个1-100的随机数，你猜： " cai
    if [ $cai -eq $num ];then
        echo "恭喜，猜对了！"
        exit
    elif [ $cai -gt $num ];then
        echo "Oops,猜大了"
    else
        echo "Oops,猜小了"
    fi
done
