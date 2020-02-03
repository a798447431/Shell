#!/bin/bash

len=( 0 0 0 )
Str=( 0 0 0 )
File=( 0 0 0 )

NumArgs=$#

FilterConf="./filter.conf"

#$1=wenjian
function Fliter() {
    FilterType=`basename $1 | tr [.] "\n" | tail -1`
    grep -q -w  "${FilterType}" ${FilterConf} 
    if [[ $? -eq 0 ]]; then
        return 1
    fi
    file $1 | grep -q -w "text"
    if [[ $? -eq 0 ]]; then
        return 1
    fi
    return 0
}

#$1 文件
function FindInFile() {
    Words=`cat $1 | tr -c -s "A-Za-z" "\n"`
    for i in ${Words}; do
        Tmp=${#i}
        if [[ ${Tmp} -ge ${Len[0]} ]]; then
            Len[2]=${Len[1]}
            Str[2]=${Str[1]}
            File[2]=${File[1]}
            Len[1]=${Len[0]}
            Str[1]=${Str[0]}
            File[1]=${File[0]}
            Len[0]=${Tmp}
            Str[0]=${i}
            File[0]=$1
        elif [[ ${Tmp} -ge ${Len[1]} ]]; then
            Len[2]=${Len[1]}
            Str[2]=${Str[1]}
            File[2]=${File[1]}
            Len[1]=${Tmp}
            Str[1]=${i}
            File[1]=$1
        elif [[ ${Tmp} -ge ${Len[2]} ]]; then
            Len[2]=${Tmp}
            Str[2]=${i}
            File[2]=$1
        fi
    done
}

#$1 目录
function FindInDir() {
    for i in `ls -A $1`;do
        TestSame $1/$i 0 ${NumArgs}
        if [[ $? -eq 0 ]]; then
            continue
        fi
        if [[ -f $1/$i ]]; then
            Fliter $1/$i 
            if [[ $? -eq 0 ]]; then
                continue
            fi
            FindInFile $1/$i
        elif [[ -d $1/$i ]];then
            FindInDir $1/$i
        else 
            return 
        fi
    done
}

function TestSame() {
    for (( x=$2; x<$3; x++ )); do
        if [[ $1 -ef ${Args[$x]} ]]; then
            return 0
        fi
    done
    return 1
}

for i in $@; do
    if [[ ! -e $i ]]; then
        exit
    fi
    Args+=($i)
done

if [[ ${NumArgs} -eq 0 ]]; then
    exit
fi

for i in `echo ${!Args[@]}`; do 
    TestSame ${Args[$i]} $[ $i + 1 ] ${NumArgs}
    if [[ $? -eq 0 ]]; then
        continue
    fi
    if [[ -d ${Args[$i]} ]]; then
        FindInDir ${Args[$i]}
    elif [[ -f ${Args[$i]} ]]; then
        FindInFile ${Args[$i]}
    else 
        continue
    fi
done

echo "${Len[0]}:${Str[0]}:${File[0]}:`grep -n -w ${Str[0]} ${File[0]} | head -n 1 |cut -d ":" -f 1`"
echo "${Len[1]}:${Str[1]}:${File[1]}:`grep -n -w ${Str[1]} ${File[1]} | head -n 1 |cut -d ":" -f 1`"
echo "${Len[2]}:${Str[2]}:${File[2]}:`grep -n -w ${Str[2]} ${File[2]} | head -n 1 |cut -d ":" -f 1`"
