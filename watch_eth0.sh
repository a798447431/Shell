#!/bin/bash 
while :
do
    echo '本地网卡wlp7s0流量信息如下：'
    ifconfig wlp7s0 | grep "RX pack" | awk '{print $5}'
    ifconfig wlp7s0 | grep "TX pack" | awk '{print $5}'
    sleep 1
done

