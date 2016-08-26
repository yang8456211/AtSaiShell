#!/bin/bash
# atany 20150918
# github 管理脚本

isTest=true

# 用户信息
userinfo(){
    echo '''
        Author: 杨光
        English Name: Atany
        GitHub: https://github.com/yang8456211
        E-mail: 347702498@qq.com
    '''
}
Ï
echo_emp(){
    echo -e "\033[31m"$1"\033[0m" 
}

echo_test(){
    [[ $isTest == true ]]&& echo $1
}

usage(){
cat << ENTER
    ==============    AtSaiShell 脚本Git处理工具      ==============
        时间:20150916
        作用:用作github的自动化管理脚本
        使用:./At_gitComm [args]
        args说明:
        1)c_user:修改GitHub提交的用户名
        2)list:列出信息
        3)init:初始化当前目录git环境
        4)push:备份代码到Github目录,push修改到remote
        ps:需要在git pro目录下操作
    ==============     AtSaiShell 脚本Git处理工具      ==============
ENTER
}

exit_pro(){
    echo "==用户退出== Abort(1)"
    exit 1
}

git_create_new_repository(){
    echo_emp "在`pwd`目录下创建git环境吗(y/n)?"
    read var
    if [[ $var == "y" || $var == "Y" ]];then    
        echo "first init" >> README.md
        git init
        git add README.md
        git commit -m "init_env"
        echo "请输入远程repository名称:"
        read repo
        git remote add origin git@github.com:yang8456211/$repo
        echo "git初始化完成,远程仓库nickname为origin,地址为git@github.com:yang8456211/$repo"
        git remote -v 
    else
        echo "Failed 用户放弃修改"
        exit 1
    fi
}

git_push(){
    git add .
    echo "请写注释:"
    read note
    git commit -m $note
    git push -u origin master
}

change_username(){
    temp_name=`git config --list | grep "user.name"`
    user_name=${temp_name##*=}
    echo "修改名字吗?原名:$user_name (y/n)"
    read var
    echo_test "var is "$var
    if [[ $var == "y" || $var == "Y" ]];then
        echo "请输入名字:"
        read name
        git config --global user.name $name
        echo "Success 修改用户名称成功!"
    else
        echo "Failed 用户放弃修改"
        exit 1
    fi
    echo "======  配置信息  ======="
    git config --list
}

if [ $# -ne 1 ];then 
    usage 
    userinfo
    exit 127
fi

opt=$1
echo_test "====>opt is $opt"

case $opt in
    "c_user") 
        change_username
        ;;
    "list")
        git config --list
        ;;
    "init") 
        git_create_new_repository 
        ;;
    "push") 
        git_push 
        ;;
    *)
        echo "参数错误:Abort(127)"
        usage
        exit 127
        ;;
esac

