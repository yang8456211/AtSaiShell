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
		export PATH=$1:${PATH} 
	else
		echo "===>(info)"$binPath" is already in the bash_profile!<SKIP>"
	fi
}

firstInit(){
	path=`pwd`
	c="sddada"
	dirname=`dirname $path`
	configPath=$dirname"/"yconfig.ini
	echo "1)Set the Script's rootPath:"$dirname"to yconfig.ini..."
	sed -i "" -e "s~atRootPath=.*~atRootPath=\"$dirname\"~g" $configPath
	echo "2)copy the yconfig.ini to "$HOME" dir..."
	cp -rf $configPath ~/
}

############################ main ############################

if [ ! -f ~/yconfig.ini ];then
	echo "Failed to Find yconfig.ini in "$HOME" directory , first init..."
	firstInit
fi

# 读取config.ini
source ~/yconfig.ini

if [[ $# != 1 || $1 != "run" ]];then
	help_fun
	editor
	exit 127
fi

echo "Be sure to install the scripts in "$scriptPath" directory?"
echo "The scripts will be install in :"$binPath"(y/n)"
read
if [[ $REPLY == "y" || $REPLY == "Y" ]];then	
	do_file $scriptPath
	add_profile $binPath
	echo "install successful!!"
else
	echo "User exit (Abort)"
	exit 1
fi