#!/bin/bash
sum=0
for i in `seq 100`
do
    sum=$[sum+i]
done
echo "总和是：$sum"
