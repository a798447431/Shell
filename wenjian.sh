#!/bin/bash
if [ $# -eq 0 ];then
    echo "未输入任何参数，请输入参数"
fi
if [ -f $1 ];then
    echo "该文件，存在"
    ls -l $1
else
    echo "没有该文件"
fi
if [ -d $2 ];then
    echo "该目录，存在"
    ls -ld $2
else 
    echo 没有该目录
fi

