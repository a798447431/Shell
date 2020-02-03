#!/bin/bash
read num

function fib() 
{
    num1=$1
    if [ $1 -lt 3 ];then
        echo $num1
        return
    fi 

    let --num1
    val1=$(fib $num1)
    let --num1
    val2=$(fib $num1)
    let ret=$val1+$val2
    echo $ret
}

ret=$(fib $num)
echo "$num:$ret"
