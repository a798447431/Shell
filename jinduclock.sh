#!/bin/bash
rotate_line(){
    INTERVAL=0.1
    COUNT="0"
    while :
    do
        COUNT=`expr $COUNT + 1`
        case $COUNT in 
        "1")
            echo -e '-'"\b\c"
            sleep $INTERVAL
            ;;
        "2")
            echo -e '\\'"\b\c"
            sleep $INTERVAL
            ;;
        "3")
            echo -e "|\b\c"
            sleep $INTERVAL
            ;;
        "4")
            echo -e "/\b\c"
            sleep $INTERVAL
            ;;
        *)
            COUNT="0";;
        esac
    done
}
rotate_line
