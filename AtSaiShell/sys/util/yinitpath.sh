#!/bin/bash
# 获取当前脚本的路径
# 如果脚本需要获取到原始路径（软连接直接是获取不到的），可以执行这个脚本，会把路径存在~/.AtSaiPath.ini

script_parent_dir=`S=\`readlink "$0"\`; [ -z "$S" ] && S=$0;dirname $S`

# 路径解析
AtSaiShell_dir=`S=\`dirname $script_parent_dir\`;dirname $S`

echo "当前根目录为:$AtSaiShell_dir"

AtSaiShell_bin=$AtSaiShell_dir"/bin"

AtSaiShell_conf=$AtSaiShell_dir"/conf"

AtSaiShell_init=$AtSaiShell_dir"/init"

AtSaiShell_sys=$AtSaiShell_dir"/sys"

AtSaiShell_sys_manager=$AtSaiShell_sys"/manager"

AtSaiShell_sys_script=$AtSaiShell_sys"/script"

AtSaiShell_sys_util=$AtSaiShell_sys"/util"


if [ -f ~/.AtSaiPath.ini ];then
    rm ~/.AtSaiPath.ini
fi

path=~/.AtSaiPath.ini
touch $path

echo  AtSaiShell_dir=$AtSaiShell_dir >> $path
echo  AtSaiShell_bin=$AtSaiShell_bin >> $path
echo  AtSaiShell_conf=$AtSaiShell_conf >> $path
echo  AtSaiShell_init=$AtSaiShell_init >> $path
echo  AtSaiShell_sys=$AtSaiShell_sys >> $path
echo  AtSaiShell_sys_manager=$AtSaiShell_sys_manager >> $path
echo  AtSaiShell_sys_script=$AtSaiShell_sys_script >> $path
echo  AtSaiShell_sys_util=$AtSaiShell_sys_util >> $path