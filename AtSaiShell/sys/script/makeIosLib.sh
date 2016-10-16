#!/bin/bash
# @auther atany
# 用于自动生成.a的静态库(合并模拟器和真机版)

# ======================   配置   ======================

# 工程路径
Proj="/Users/a123/yg/ios/Proj/SDKCall"

# Target名称
Target_Name="SDKCall"

# 文件输出路径
Outpath="/Users/a123/yg/ios/Sdk"

# .a名称
DotA="libSDKCall.a"

Tmp_path="TMP_LIB"

# ======================   配置   ======================

Iphonesimulator="Release-iphonesimulator"
Iphoneos="Release-iphoneos"

# ======================   配置   ======================
build_a(){
    xcodebuild -target ${Target_Name} clean
    xcodebuild -target ${Target_Name} -configuration Release -sdk iphonesimulator
    xcodebuild -target ${Target_Name} -configuration Release -sdk iphoneos
}

clean_dir(){
    if [[ ! -d $Build_root ]];then
        echo "build文件夹不存在，退出!!"
        exit 100
    else
        rm -rf $Build_root/*
        echo "====>清空旧的build数据，清空成功!!"
    fi
}

create_a(){
    # 清理
    clean_dir

    date=`date +%m%d%H%M%S`

    tmp_file=$Tmp_path"/"$date".txt"

    touch $tmp_file

    # 打包
    build_a >> $tmp_file

    # 合并
    lipo -create $1 $2 -output $3 >> $tmp_file

    # 拷贝
    out_path=""

    if [[ $tar == "dyb" ]];then
        out_path=$Outpath"/dyb/"$DotA
        cp -rf $3 $out_path
    elif [[ $tar == "3595" ]];then
        out_path=$Outpath"/3595/"$DotA
        cp -rf $3 $out_path
    else
        echo "异常错误@!!"
        exit 99
    fi

    echo ".a 生成成功("$out_path")"
    md5 $out_path
    sleep 1s
}

if [ $# < 4 ];then
    echo "参数错误"
fi

Proj=$1
Target_Name=$2
Outpath=$3
DotA=$4

# build路径
Build_root=$Proj"/build"

sim_a=$Build_root"/"$Iphonesimulator"/"$DotA
os_a=$Build_root"/"$Iphoneos"/"$DotA
out_a=$Build_root"/"$DotA

out_path_diyibo=$Outpath"/dyb/"$DotA
out_path_3595=$Outpath"/3595/"$DotA

cd $Proj

create_a $sim_a $os_a $out_a
