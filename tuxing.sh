#!/bin/bash
clear
for ((i=1;i<=9;i++))
do
    for ((j=1;j<=i;j++))
    do
        echo -n "$i"
    done
    echo ""
done
