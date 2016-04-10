#!/bin/bash

# 读取config.ini
source ~/config.ini
isTest=$isTest
binPath=$binPath
scriptPath=$scriptPath


echo $binPath
echo $scriptPath

help_fun(){
cat << ENTER
	 ============= 脚本安装工具 =============
	 Version: 0.1
	 Date: 20160330
	 Usage: 用作初始安装自己的脚本环境
	 e.g.: sh install.sh run
	 ============= 脚本安装工具 =============
ENTER
}

echo_emp(){
	echo -e "\033[31m"$1"\033[0m" 
}

echo_test(){
	[[ $isTest == true ]] && echo $1
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
		echo "===>(warn):"$linkPath" is exist,remove it!"
		rm $linkPath
	fi
	ln -s $filePath $linkPath
	echo "===>(info):link file "$filePath" -----> "$linkName" successful!"
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
			if [[ ! $basename == "install.sh" && ! $basename == "config.ini" ]];then
				link_file $file
			fi
		fi
	done
}

add_profile()
{
	isIn=`cat ~/.bash_profile | grep $1`
	echo_test "isIn is "$isIn
	if [[ x"$isIn" == x	]];then
		echo "\n#Setting PATH FOR LOCAL SCRIPT" >> ~/.bash_profile
		echo "export PATH=\"$1:\${PATH}\"" >> ~/.bash_profile
		echo "===>(info)"$binPath" is added to bash_profile successful!"
		export PATH=$1:${PATH} #只是加到了内存中，新开终端失效
	else
		echo "===>(info)"$binPath" is already in the bash_profile!<SKIP>"
	fi
}


if [[ $# != 1 || $1 != "run" ]];then
	help_fun
	editor
	exit 2
fi

echo "是否对"$scriptPath"目录下的脚本进行安装?"
echo "安装目录为:"$binPath"(y/n)"
read
if [[ $REPLY == "y" || $REPLY == "Y" ]];then	
	do_file $scriptPath
	add_profile $binPath
	echo "脚本环境安装成功!!"
else
	echo "用户终止exit (Abort)"
	exit 0
fi