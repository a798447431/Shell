#!/bin/bash

TIME_INTERVAL=0.5
CPU_THERMAL=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{printf "%.2f", $1/1000}')
LoadAvg=`cut -d " " -f 1-3 /proc/loadavg`
TIME=$(date +"%Y-%m-%d__%H:%M:%S")

eval `head -n 1 /proc/stat | awk -v sum1=0 -v idle1=0 '{for(i=2;i<=8;i++) {sum1+=$i} printf("sum1=%.0f;idle1=%.0f;", sum1, $5)}'`
sleep $TIME_INTERVAL
eval `head -n 1 /proc/stat | awk -v sum2=0 -v idle2=0 '{for(i=2;i<=8;i++) {sum2+=$i} printf("sum2=%.0f;idle2=%.0f;", sum2, $5)}'`

echo $idle1 $idle2 $sum1 $sum2

CpuUsedPerc=`echo "scale=4;(1-($idle2-$idle1)/($sum2-$sum1))*100" | bc`

CpuUsedPerc=`printf "%.2f" $CpuUsedPerc`

WarnLevel="normal"

if [[ `echo $CPU_THERMAL '>=' 70 | bc -l` == 1 ]]; then
    WarnLevel="warning"
elif [[ `echo $CPU_THERMAL '>=' 50 | bc -l` == 1 ]]; then
    WarnLevel="note"
fi

echo "${TIME} ${LoadAvg} ${CpuUsedPerc} ${CPU_THERMAL} ${WarnLevel}"
