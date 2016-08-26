#!/bin/bash
# @auther atany
# 修改python版本

which_python=`which python`

P3="/usr/local/Cellar/python3/3.3.3/bin/python3"
P2="/usr/local/Cellar/python/2.7.11/bin/python2.7"

help(){
cat <<ENTER
    e.g. sh pyversion.sh [version] -- (2/3)
        2 : Python 2.3
        3 : Python 3
    Usage : 快速修改本机的 Python 版本，请先配置Python路径，修改完成之后请使用[python]查看版本

    
ENTER
}

changeVersion(){    
    case $1 in
        "3" )
        [[ -L $python ]] && rm -r $which_python
        ln -s $P3 $which_python
            ;;
        "2" )
        [[ -L $python ]] && rm -r $which_python
        ln -s $P2 $which_python
            ;;
        "d") # Mac 自带的默认的python 路径
        [[ -L $python ]] && rm -r $which_python
        ln -s "/System/Library/Frameworks/Python.framework/Versions/2.7/bin/python2.7" $which_python
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

