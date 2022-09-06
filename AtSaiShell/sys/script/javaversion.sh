#!/bin/bash
# @auther atany
# 修改本地Java的版本
# 注意：mac 10.11 不能修改/usr/bin文件夹里面的软链接，如果 `which java`指令的软链接是/usr/bin中的，请先关闭SIP 或者修改软链接的位置，再使用本脚本
# 修改：2018/6/3 因为SIP的原因，所以中/usr/local/bin/中新建了一个java的软连接进行处理。（删除掉所以需要sudo的东西）

#which_java=`which java`
which_java="/usr/local/bin/java"

# 需要配置本机的路径
JDK6="/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/bin/java"
JDK7="/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home/bin/java"
JDK8="/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/bin/java"

help(){
cat <<ENTER
    e.g. sh javaversion.sh [version] -- (6/7/8)
        6 : JDK 1.6
        7 : JDK 1.7
        8 : JDK 1.8
    Usage : 快速修改本机的 JDK 版本，请先配置JDK路径，修改完成之后请使用[java -version]查看版本
ENTER
}

changeVersion(){    
    case $1 in
        "6" )
        rm -r $which_java
        ln -s $JDK6 $which_java
            ;;
        "7" )
        rm -r $which_java
        ln -s $JDK7 $which_java
            ;;
        "8")
        rm -r $which_java
        ln -s $JDK8 $which_java
            ;;
        * )
            echo "Error,JDK版本输入错误!"
            help
            exit 0
            ;;
    esac
}


if [[ $# != 1 ]];then
    help
    exit 0
fi

echo "==>"$which_java

version=$1

changeVersion $version

echo "修改成功!"

