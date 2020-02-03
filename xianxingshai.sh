#!/bin/bash
declare -a prime
sum=0
function init() {
    for i in `seq 1 1000`;do
        eval $1[$i]=0
    done
}

init prime

for ((i=2; i<1000; i++)); do
    if [[ ${prime[$i]} -eq 0 ]]; then
        echo $i
        let sum+=$i
    else
        continue
    fi
    for ((j=i; i*j<1000; j++)); do
       prime[$[ $i * $j ]]=1
    done
done
echo $sum

