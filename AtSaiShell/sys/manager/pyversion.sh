#!/bin/bash
# @auther yangguang
# 修改python版本

which_python="/usr/local/bin/python"

help(){
cat <<ENTER
	sh pyversion.sh [version] -- (2/3)
ENTER
}

changeVersion(){
	python=`which python`
	echo $python
	
	case $1 in
		"3" )
		[[ -L $python ]] && rm -r $which_python
		ln -s "/usr/local/Cellar/python3/3.3.3/bin/python3" $which_python
			;;
		"2" )
		[[ -L $python ]] && rm -r $which_python
		ln -s "/usr/local/Cellar/python/2.7.11/bin/python2.7" $which_python
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

