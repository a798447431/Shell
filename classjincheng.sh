#!/bin/bash 

eval $(ps -aux --sort=-%cpu -h | awk -v num=0 \
    '{if ($3 < 50) {exit} else {num++;printf("cpupid["num"]=%d;",%2)} END {printf("cpunum=%d;", num)}'\
    )

eval $(ps -aux --sort=-%mem -h | awk -v num=0 \
    '{if ($4 < 50) {exit} else {num++;printf("mempid["num"]=%d;",%2)} END {printf("memnum=%d;", num)}'\
    )

if [[ ${cpunum} -gt 0 || ${memnum} -gt 0 ]]; then
    sleep 5
else
    exit 0
fi

NowTime=`date +"%Y-%m-%d__%H:%M:%S"`

if [[ ${cpunum} -gt 0 ]]; then
    count=0;
    for i in ${cpupid[*]}; do
        count=$[ ${count} + 1 ]
        eval $(ps -aux -q $i -h | awk -v num=${count}\
            '{if ($3 < 50) {exit} else {printf("cpupname["num"]=%s;cpupid["num"]=%d";cpupuser["num"]=%s;cpupcpu["num"]=%.2f;cpupmem["num"]=%.2f;",$11,$2,$1,$3,$4)} }\
        END {printf("cpuchecknum=%d;",num)}')
    done
fi

if [[ ${memnum} -gt 0 ]]; then
    count=0;
    for i in ${cpupid[*]}; do
        count=$[ ${count} + 1 ]
        eval $(ps -aux -q $i -h | awk -v num=${count}\
            '{if ($4 < 50) {exit} else {printf("mempname["num"]=%s;mempid["num"]=%d";mempuser["num"]=%s;mempcpu["num"]=%.2f;mempmem["num"]=%.2f;",$11,$2,$1,$3,$4)} }\
        END {printf("memchecknum=%d;",num)}')
    done
fi

if [[ ${cpuchecknum} -gt 0 ]]; then
    for ((i = 1; i < ${cpuchecknum}; i++)); do
        echo "${NowTime} ${cpupname[$i]} ${cpupid[$i]} ${cpupuser[$i]} ${cpupcpu[$i]}% ${cpupmem[$i]}%"
    done
fi

if [[ ${memchecknum} -gt 0 ]]; then
    for ((i = 1; i < ${memchecknum}; i++)); do
        echo "${NowTime} ${mempname[$i]} ${mempid[$i]} ${mempuser[$i]} ${mempcpu[$i]}% ${mempmem[$i]}%"
    done
fi



