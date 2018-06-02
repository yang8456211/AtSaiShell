#!/bin/bash
# @auth atany 347702498@qq.com
# blog : http://blog.csdn.net/yang8456211
# useage : for crontab


logFileName=.ycrontab.log
logFilePath=~/$logFileName

run_task(){
    pyPath="/Users/yangguang/Just_for_fun/Python/proj/Mail/DownLoadMail.py"
    python $pyPath >> $logFilePath
}

echo `date "+%Y-%m-%d %H:%M:%S"`":Auto Run ycrontab start" >> ~/$logFileName

run_task

echo `date "+%Y-%m-%d %H:%M:%S"`":Auto Run ycrontab end" >> ~/$logFileName
