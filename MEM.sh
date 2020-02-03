#!/bin/bash
#时间
date=$(date +"%Y-%m-%d__%H:%M:%S")
#内存总量
MemTotal=`free -m | grep -w Mem | awk '{print $2}'`
echo $MemTotal
MemFree=`free -m | grep -w Mem | awk '{print $4}'`
echo $MemFree
MemUsed=`free -m | grep -w Mem | awk '{print $3}'`
echo $MemUsed
