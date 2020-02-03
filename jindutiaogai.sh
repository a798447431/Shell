#!/bin/bash 
str=""
arr=('-' '\' '|' '/')
for (( i=1; i<=100; ++i))
do
    let tmp=${i}%4
    str+="#"
    printf "[%-100s][${i}%%] ${arr[$tmp]} \r" "${str}"
    sleep 0.1 
done
printf "\n"
