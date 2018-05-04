#!/bin/bash
# @auther atany
# 修改Xcode的版本

# 需要配置本机的路径
XCODE8="/Applications/Xcode8_0.app"
XCODE9="/Applications/Xcode.app"

help(){
cat <<ENTER
    e.g. sh xcodeversion.sh [version] -- (8/9)
        8 : XCODE8
        9 : XCODE9
    Usage : 快速修改XCODE的默认指定的版本
ENTER
}

changeVersion(){    
    case $1 in
        "8" )
            sudo xcode-select -s $XCODE8
            ;;
        "9")
            sudo xcode-select -s $XCODE9
            ;;
        * )
            echo "Error,参数输入错误!"
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
sudo xcode-select -p

