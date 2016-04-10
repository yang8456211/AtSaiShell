#!/bin/bash

source ~/config.ini

help_fun(){
cat << ENTER
     ============= 脚本管理工具 =============
     Version: 0.1
     Date: 20160406
     Usage: 用于管理脚本的工具
     e.g.: sh ywork.sh -a (list/detail): Show all script and Usage   
                       -h : Help
                       -e : Edit config.ini
     ============= 脚本管理工具 =============
ENTER
}

modifyConfig(){
    vi ~/config.ini
}

showAllScript(){
    # binPath config.ini 里读取的脚本安装的目录
    for i in `ls $binPath`
    do
        if [[ $1 == "detail" ]];then
            echo -e "\033[31m_________ "$i" _________\033[0m"
            eval $i
            echo

        elif [[ $1 == "list" ]];then
            echo $i
        fi
    done
}


[[ $# == 0 ]] && echo "==>ywork -h 查看帮助" && editor && exit 100

# 选项后面的冒号表示该选项需要参数,参数存在$OPTARG中
while getopts "a:he" arg 
do
    case $arg in
        a)
            showAllScript $OPTARG
            ;;
        h)
            help_fun
            ;;
        e)
            modifyConfig
            ;;
        ?)  
            echo "Unkonw argument Abort(101)" 
            exit 101
        ;;
    esac
done
