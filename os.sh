#!/bin/bash
TIME=$(date +"%Y-%m-%d__%H:%M:%S")
HOSTNAME=`hostname`
OS_INFO=`cat /etc/issue | cut -d " " -f 1-3 | tr " " "_"`
CORE_INFO=`cat /proc/version | cut -d " " -f 3`
OS_TIME=(`uptime | tr -s -c 'a-zA-Z0-9.:\n' ' ' | cut -d ' ' -f 3-4,6 | tr -s -c 'a-z0-9.\n' ' '`)
OS_LOAD=`uptime | tr -s -c 'a-zA-Z0-9.:\n' ' ' | cut -d ' ' -f 11-13 | tr -s -c 'a-z0-9.\n' ' '`

DISK_INFO=(`df -m | grep ^/dev | awk '{printf("%s %s\n",$2,$4)}'`)
DISK_NUM=`df -m | grep ^/dev | wc -l`
ALL_DISK_USE=0
ALL_DISK_FREE=0
for ((i = 0; i < ${#DISK_INFO[@]}; i+=2))
do
    ((ALL_DISK_USE=${ALL_DISK_USE}+${DISK_INFO[i]}))
    ((ALL_DISK_FREE=${ALL_DISK_FREE}+${DISK_INFO[i+1]}))
done

MemValue=(`free -m | grep -w Mem | awk '{printf("%d %d"), $3, $2}'`)
MemLeft=`echo "${MemValue[1]}-${MemValue[0]}" | bc`
MemAvaPrec=`echo "scale=1;${MemValue[0]}*100/${MemValue[1]}" | bc`

CPU_THERMAL=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{printf "%.2f", $1/1000}')

if [[ ${ALL_DISK_SCALE} -gt 90 ]];then
    LOG_INFO[0]="warning"
elif [[ ${ALL_DISK_SCALE} -gt 80 ]];then
    LOG_INFO[0]="note"
else
    LOG_INFO[0]="normal"
fi

if [[ `echo ${MemAvaPrec} '>=' 90 | bc -l` == 1 ]];then
    LOG_INFO[1]="warning"
elif [[ `echo ${MemAvaPrec} '>=' 80 | bc -l` == 1 ]];then
    LOG_INFO[1]="note"
else
    LOG_INFO[1]="normal"
fi

if [[ `echo $CPU_THERMAL '>=' 90 | bc -l` == 1 ]];then
    LOG_INFO[2]="warning"
elif [[ `echo $CPU_THERMAL '>=' 80 | bc -l` == 1 ]];then
    LOG_INFO[2]="note"
else
    LOG_INFO[2]="normal"
fi

echo "${TIME} $HOSTNAME $OS_INFO $CORE_INFO ${OS_TIME[0]}_${OS_TIME[1]}_day,_${OS_TIME[2]}_hours,_${OS_TIME[3]}_minutes ${OS_LOAD} ${ALL_DISK_USE} ${ALL_DISK_SCALE} ${CPU_THERMAL}% ${LOG_INFO[0]} ${LOG_INFO[2]} ${LOG_INFO[2]}"

