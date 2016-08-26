#!/bin/bash
# @auther atany
# 修改本地Java的版本

which_java="/usr/bin/java"

help(){
cat <<ENTER
    sh javaversion.sh [version] -- (6/7/8)
ENTER
}

changeVersion(){
    java=`which java`
    echo $java
    
    case $1 in
        "6" )
        [[ -L $java ]] && sudo rm -r $which_java
        sudo ln -s "/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/bin/java" $which_java
            ;;
        "7" )
        [[ -L $java ]] && sudo rm -r $which_java
        sudo ln -s "/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home/bin/java" $which_java
            ;;
        "8")
        [[ -L $java ]] && sudo rm -r $which_java
        sudo ln -s "/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/bin/java" $which_java
            ;;
        * )
            echo "error,输入错误"
            help
            exit 0
            ;;
    esac
}


if [[ $# != 1 ]];then
    help
    exit 0
fi

version=$1

changeVersion $version

echo "修改成功!"

