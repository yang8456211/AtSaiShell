#!/bin/bash
# 测试脚本

# 需要获得路径的时候调用yinitpath,然后source ~/.AtSaiPath.ini 获得路径
yinitpath

source ~/.AtSaiPath.ini
source ../conf/.yconfig.ini

echo $AtSaiShell_dir
echo $AtSaiShell_bin
echo $AtSaiShell_conf
echo $AtSaiShell_init
echo $AtSaiShell_sys
echo $AtSaiShell_sys_manager
echo $AtSaiShell_sys_script
echo $AtSaiShell_sys_util

for i in ${ignoreBinName[*]};do
	echo $i
done
