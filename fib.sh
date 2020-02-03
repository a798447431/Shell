#!/bin/bash
list=(0 1)
for i in `seq 2 11`
do
    list[$i]=`expr ${list[-1]} + ${list[-2]}`
done
echo ${list[@]}
