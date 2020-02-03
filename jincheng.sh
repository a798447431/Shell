#!/bin/bash
TIME=$(date +"%Y-%m-%d__%H:%M:%S")

eval $(ps -auxh --sort=-%cpu | awk -v cpunum=0 '$3>=50{cpunum+=1; printf("cpu["cpunum"]=%d", $2)}')

eval $(ps -auxh --sort=-%mem | awk -v memnum=0 '$3>=50{memnum+=1; printf("mem["memnum"]=%d", $2)}')

if [[ ${cpunum} -gt 0 || ${memnum} -gt 0 ]];then
    sleep 5
else
    exit 0
fi

if [[ ${cpunum} -gt 0 ]];then
    for i in ${cpu[*]};do
        eval $(ps -auxhq $i | awk -v cpuflag=0 '$3>=50{cpuflag+=1;printf("cpu_info_name["cpuflag"]=%s;cpu_info_uid["cpuflag"]=%d;cpu_info_user["cpuflag"]=%s;cpu_cpu_use["cpuflag"]=%2.2f;cpu_mem_use["cpuflag"]=%2.2f",$11,$2,$1,$3,$4)}')
    done
fi

if [[ ${memnum} -gt 0 ]];then
    for i in ${mem[*]};do
        eval $(ps -auxhq $i | awk -v memflag=0 '$4>=50{memflag+=1;printf("mem_info_name["memflag"]=%s;mem_info_uid["memflag"]=%d;mem_info_user["memflag"]=%s;mem_cpu_use["memflag"]=%2.2f;mem_mem_use["memflag"]=%2.2f",$11,$2,$1,$3,$4)}')
    done
fi

if [[ ${cpuflag} -eq 0 && ${memflag} -eq 0 ]];then
    exit 0
fi

if [[ ${cpuflag} -gt 0 ]];then
    for ((i=1;i<=${cpuflag};i++));do
        echo "${TIME} ${cpu_info_name[$i]} ${cpu_info_uid[$i]} ${cpu_info_user[$i]} ${cpu_cpu_use[$i]}% ${cpu_mem_use[$i]}%"
    done
fi

if [[ ${memflag} -gt 0 ]];then
    for ((i=1;i<=${memflag};i++));do
        echo "${TIME} ${mem_info_name[$i]} ${mem_info_uid[$i]} ${mem_info_user[$i]} ${mem_cpu_use[$i]}% ${mem_mem_use[$i]}%"
    done
fi


