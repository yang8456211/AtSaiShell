#!/bin/bash

help_fun(){
cat << ENTER
     ============= Install For The Script =============
     Version: 0.1
     Date: 20160330
     Usage: Init the env and install the scripts 
     e.g.: sh install.sh run
     ============= Install For The Script =============
ENTER
}

editor(){
    echo '''
        @auther: 杨光（Atany）
        @blog: http://blog.csdn.net/yang8456211
        @github: https://github.com/yang8456211
        @email: atany9787@163.com
    '''
}

echo_emp(){
    echo -e "\033[31m"$1"\033[0m" 
}

echo_test(){
    [[ $isTest == true ]] && echo $1
}

exit_pro(){
    echo "==User exit== Abort(1)"
    exit 1
}

link_file()
{
    filePath=$1
    fileName=`basename $1`
    linkName=${fileName%.*} #去除后缀
    linkPath=$bin_path"/"$linkName

    if [[ -L $linkPath ]];then
        echo_test "===>(warn):"$linkPath" 软连接已经存在，首先删除!"
        rm $linkPath
    fi
    ln -s $filePath $linkPath
    echo "===>link file "$filePath" --> "$linkName""

    # 修改权限
    chmod 777 $linkPath
}

do_file()
{
    for file in $1/*
    do 
        if [[ -d "$file" ]]; then
            do_file "$file"
        else
            basename=`basename $file`
            echo_test $basename
            link_file $file
        fi
    done
}

add_profile()
{
    isIn=`cat ~/.zshrc | grep $1`
    echo_test "isIn is "$isIn
    if [[ x"$isIn" == x ]];then
        echo "\n#Setting PATH FOR LOCAL SCRIPT" >> ~/.zshrc
        echo "export PATH=\"$1:\${PATH}\"" >> ~/.zshrc
        echo "==>"$bin_path" is added to zshrc!"
        export PATH=$1:${PATH} 
    else
        echo "==>"$bin_path" 在zshrc中已经存在!<SKIP>"
    fi
}

set_root_path(){
    if [[ ! -d ~/.AtSaiShell ]];then
        mkdir ~/.AtSaiShell
    fi

    if [[ ! -f ~/.AtSaiShell/root_config.ini ]];then
        touch ~/.AtSaiShell/root_config.ini
        echo "root_path=" > ~/.AtSaiShell/root_config.ini
        echo_test "Home目录配置文件生成成功"
    fi

    sed -i '' "s~root_path=.*~root_path="$root_path"~g" ~/.AtSaiShell/root_config.ini
}

############################ main ############################

if [[ $# != 1 || $1 != "run" ]];then
    help_fun
    editor
    exit 127
fi

root_path=`dirname "$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"`
config_path=$root_path"/conf/.yconfig.ini"
source $config_path

# 设置rootpath
set_root_path

if [[ $isTest == "true" ]];then
	echo_emp "(当前属于调试模式,在脚本运行过程中会打印调试日志)"
fi

echo ">>>(当前工程跟目录为:$root_path)\n------------------------------------------\n"
echo "Begin Install.."

script_path=$root_path"/sys"
bin_path=$root_path"/bin"

echo "确认安装"$script_path"下脚本?"
echo ">脚本软连接将会被创建到:"$bin_path"目录。\n请输入(y/n):"
read
if [[ $REPLY == "y" || $REPLY == "Y" ]];then    
    do_file $script_path
    add_profile $bin_path
    echo "安装完成!!"
else
	exit_pro
fi

