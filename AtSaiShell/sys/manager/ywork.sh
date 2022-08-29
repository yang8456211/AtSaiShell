#!/bin/bash

source ~/.AtSaiShell/root_config.ini

config_path=$root_path"/conf/.yconfig.ini"

source $config_path

help_fun(){
cat << ENTER
     ============= 脚本管理工具 =============
     Version: 0.1
     Date: 20160406
     Usage: 用于管理脚本的工具
     e.g.: sh ywork.sh -a [args]  --(list/detail): Show all script and Usage   
                           list : 查看可用脚本
                           detail : 查看所有可用脚本的使用说明
                       -h : Help
                       -e : Edit config.ini
     ============= 脚本管理工具 =============
ENTER
}

modifyConfig(){
    vi $config_path
}

showAllScript(){
    binPath=$root_path"/bin"
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


[[ $# == 0 ]] && echo "==>ywork -h 查看帮助" && exit 100

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
            echo "Unkonw argument Abort" 
            exit 126
        ;;
    esac
done
