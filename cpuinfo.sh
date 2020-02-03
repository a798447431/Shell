#!/bin/bash

TIME_INTERVAL=0.5
CPU_THERMAL=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{printf "%.2f", $1/1000}')
LoadAvg=`cut -d " " -f 1-3 /proc/loadavg`
TIME=$(date +"%Y-%m-%d__%H:%M:%S")

LAST_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
LAST_SYS_IDLE=$(echo $LAST_CPU_INFO | awk '{print $4}')
LAST_TOTAL_CPU_T=$(echo $LAST_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')

sleep ${TIME_INTERVAL}

NEXT_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
NEXT_SYS_IDLE=$(echo $NEXT_CPU_INFO | awk '{print $4}')
NEXT_TOTAL_CPU_T=$(echo $NEXT_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')

SYSTEM_IDLE=`echo ${NEXT_SYS_IDLE} ${LAST_SYS_IDLE} | awk '{print $1-$2}'`
TOTAL_TIME=`echo ${NEXT_TOTAL_CPU_T} ${LAST_TOTAL_CPU_T} | awk '{print $1-$2}'`

CPU_USAGE=`echo ${SYSTEM_IDLE} ${TOTAL_TIME} | awk '{printf "%.2f", 100-$1/$2*100}'`

echo "${TIME} ${LoadAvg} ${CPU_USAGE} ${CPU_THERMAL}℃  note"

