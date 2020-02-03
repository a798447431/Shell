#!/bin/bash
TIME=$(date +"%Y-%m-%d__%H:%M:%S")
DISK_INFO=(`df -m | grep ^/dev | awk '{printf("%s %s %s %s\n",$6,$2,$4,$5)}'`)
DISK_NUM=`df -m | grep ^/dev | wc -l`
ALL_DISK_USE=0
ALL_DISK_FREE=0
for ((i = 0; i < ${#DISK_INFO[@]}; i+=4)) 
do
    echo ${TIME} 1 ${DISK_INFO[i]} ${DISK_INFO[i+1]} ${DISK_INFO[i+2]} ${DISK_INFO[i+3]} 
    ((ALL_DISK_USE=${ALL_DISK_USE}+${DISK_INFO[i+1]}))
    ((ALL_DISK_FREE=${ALL_DISK_FREE}+${DISK_INFO[i+2]}))
done
ALL_DISK_SCALE=`echo "100-${ALL_DISK_FREE}*100/${ALL_DISK_USE}" | bc`
echo ${TIME} 0 "disk" ${ALL_DISK_USE} ${ALL_DISK_FREE} ${ALL_DISK_SCALE}%
