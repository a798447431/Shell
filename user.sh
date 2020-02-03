#!/bin/bash
TIME=$(date +"%Y-%m-%d__%H:%M:%S")
ALL_USER=$(awk -F : '$3>=1000{print $1}' /etc/passwd | grep -v nobody | wc -l)
GREAT_USER=(`last | cut -d " " -f 1 | grep -vwE "wtmp|reboot|root|shutdown" | sort | uniq -c | sort -rn | head -n 3 | awk '{print $2}'`)
ROOT_USER=(`cat /etc/group | grep sudo | awk -F : '{print $4}' |cut -d ',' -f 1-`)
USER_INFO=`w | awk 'NR == 1 {next} NR == 2 {next} {print ","$1"_"$3"_"$2}' | tr -d '\n' | cut -d ',' -f 2-`
echo "${TIME} ${ALL_USER} [${GREAT_USER[0]},${GREAT_USER[1]},${GREAT_USER[2]}] [${ROOT_USER[*]}] [${USER_INFO}]"

