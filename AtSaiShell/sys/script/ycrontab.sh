#!/bin/bash
# @auth atany 347702498@qq.com
# blog : http://blog.csdn.net/yang8456211
# useage : for crontab

usage(){
cat << ENTER
    ==============    ycrontab    ==============
        作用:ycrontab 
        使用:./ycrontab run
    ==============    ycrontab    ==============
ENTER
}

run_task(){
    pyPath="/Users/yangguang/Just_for_fun/Python/proj/Mail/DownLoadMail.py"
    python $pyPath >> $logFilePath
}


if [ $# -ne 1 ];then 
    usage 
    exit 127
fi

opt=$1
if [[ $opt == "run" ]];then 

    logFileName=.ycrontab.log
    logFilePath=~/$logFileName


    echo `date "+%Y-%m-%d %H:%M:%S"`":Auto Run ycrontab start" >> ~/$logFileName

    run_task

    echo `date "+%Y-%m-%d %H:%M:%S"`":Auto Run ycrontab end" >> ~/$logFileName
fi