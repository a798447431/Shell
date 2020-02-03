#!/bin/bash
for i in `seq 9`
do
    for j in `seq $i`
    do
        echo -n "$i*$j=$[i*j] "
    done
    echo
done
