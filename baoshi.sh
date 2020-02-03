#!/bin/bash
TimeBegin=`date +%s`
RestBegin=0

function CheckTime() {
    TimeNow=`date +%s`
    TimeBetween=$[ (${TimeNow} - ${TimeBegin}) / 60 ]
    if [[ ${TimeBetween} -ge 45 ]]; then
        return 1
    fi
    return 0
}

function RestTime() {
    TimeNow=`date +%s`
    TimeBetween=$[ ${TimeNow} - ${RestBegin} ]
    if [[ ${TimeBetween} -ge 5 ]]; then
       return 1
    fi
    return 0
}

function CheckZero() {
    Min=`date +%M`
    if [[ ${Mini} == "00" ]]; then
        return 1
    fi
    return 0
}

while [[ TRUE ]]; do
    sleep 5
    CheckTime
    if [[ $? -eq 1 ]]; then
        echo "45"
        RestBegin=`date +%s`
        RestBegin=`date +%s`
    fi
    if [[ !${RestBegin}x == x ]]; then
        RestTime
    fi
    if [[ $? -eq 1 ]]; then
        echo "Rest Time out"
        TimeBegin=`date +%s`
    fi
    CheckZero
    if [[ $? -eq 1 ]]; then
        echo "00"
    fi
done


