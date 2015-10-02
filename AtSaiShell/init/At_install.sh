#!/bin/bash
isTest=false

echo_emp(){
	echo -e "\033[31m"$1"\033[0m" 
}

echo_test(){
	[[ $isTest == true ]]&& echo $1
}

# 用户信息
userinfo(){
	echo '''
		Author: 杨光
		English Name: Atany
		GitHub: https://github.com/yang8456211
		E-mail: 347702498@qq.com
	'''
}

# 脚本说明
usage(){
cat << ENTER
	 ============= AtSaiShell 脚本初始化工具 =============
	 Version:0.1
	 Date:20150812
	 Usage:用作初始安装AtSaiShell脚本的环境
	 eg: sh At_install.sh [install Path]
	 ============= AtSaiShell 脚本初始化工具 =============
ENTER
}

exit_pro(){
	echo "==用户退出== Abort(1)"
	exit 1
}

link_file()
{
	filePath=$1
	fileName=`basename $1`
	linkName=${fileName%.*}
	linkPath=$binPath"/"$linkName
	if [[ -L $linkPath ]];then
		echo_test "===>(warn):"$linkPath" is exist,remove it!"
		rm $linkPath
	fi
	ln -s $filePath $linkPath
	echo_test "===>(info):link file "$filePath" -----> "$linkName" successful!"
	chmod 777 $linkPath
}

do_file()
{
	for file in $1/*
	do 
		if [[ -d "$file" ]]; then
			do_file "$file"
		else
			link_file $file
		fi
	done
}

add_profile()
{
	absPath=$(cd $1; pwd)
	echo_test "@@absPath is "$absPath
	isIn=`echo $PATH | grep $absPath`
	echo_test "isIn is "$isIn
	if [[ x"$isIn" == x	]];then
		echo "\n#Setting PATH FOR AtSaiShell" >> ~/.bash_profile
		echo "export PATH=\"$1:\${PATH}\"" >> ~/.bash_profile
		echo "===>(info)"$binPath" is added to bash_profile successful!"
	else
		echo "===>(info)"$binPath" is already in the bash_profile!<SKIP>"
	fi
}

if [[ $# != 1 ]];then
	echo "未检测到安装路径!"
	usage
	userinfo
	exit 127
fi

# 安装路径
binPath=$1

fileAbsPath=$(cd `dirname $0`; pwd)
sysPath=${fileAbsPath%/*}"/sys"

echo "==>确认把 AtSaiShell 脚本环境安装到"$binPath"目录下?(y/n)"
read
if [[ $REPLY == "y" || $REPLY == "Y" ]];then
	if [[ ! -d $binPath ]];then
		echo "目录不存在!创建目录$binPath"
		mkdir -p $binPath
	fi
	do_file $sysPath
	add_profile $binPath
	echo "AtSaiShell 脚本环境安装成功!!"
else
	exit_pro
fi