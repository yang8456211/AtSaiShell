#!/bin/bash

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
	 ============= AtSaiShell 脚本SVN处理工具 =============
	 Version:0.1
	 Date:20140804
	 Usage:用作批量提交svn的文件
	 eg: sh At_svnCommm.sh [opt] [arg]
	 opt arg : 
        1.-d 目录(可选)
		2.-m 注释(可选)
	 example :
        1. sh At_svnCommm.sh -n                                   --提交当前目录到svn
        2. sh At_svnCommm.sh -d "/usr/local/bin"	            --提交"/usr/local/bin"内容到svn
        3. sh At_svnCommm.sh -d "/usr/local/bin" -m "提交svn"    --提交"/usr/local/bin"内容到svn,添加注释"提交svn"
	 ============= AtSaiShell 脚本SVN处理工具 =============
ENTER
}

checkSvn()
{
	case $1 in
		"?" ) 
		echo "svn add" $svnDir"/"$2 >> $svnTempFileRun 
		;;
		"A") 
		echo "svn add" $svnDir"/"$2 >> $svnTempFileRun
		;;
		"M") 
		echo "svn update" $svnDir"/"$2 >> $svnTempFileRun
		;;
		"!")
		echo "svn delete" $svnDir"/"$2 >> $svnTempFileRun
		;;
		"D")
		echo "svn delete" $svnDir"/"$2 >> $svnTempFileRun
		;;
		*) 
		echo $1 $2 >> $svnTempError
		;;
	esac
}

if [[ $# == 0 ]];then
	usage
	exit 127
fi

svnDir=""
commitM=""

while getopts "nd:m:" arg
do 
	case $arg in
		n)
			svnDir=`pwd`
		;;
		d) svnDir=$OPTARG
		;;
		m) commitM=$OPTARG
		;;
		?) echo "！！参数有误,退出(0)！" ; exit 0
		;;
	esac
done

if [[ $svnDir == "m" || $svnDir == "-m" || $commitM == "d" || $commitM == "-d" ]];then
	echo "！！参数有误,退出(127)！" 
	exit 127
fi

if [[ -d $svnDir ]];then
	echo "提交svn目录为:"$svnDir
else
	echo "svn目录"$svnDir"不存在，终止"
	exit
fi

tempDir="$HOME/TMP"
svnTempFile=$tempDir"/svnCiTemp.txt"
svnTempFileRun=$tempDir"/svnCiTemp.sh"
svnTempError=$tempDir"/svnCiError.txt"

#删除Home目录下的操作目录和临时文件
[[ -f $svnTempFileRun ]] && rm $svnTempFileRun
[[ -f $svnTempFile ]] && rm $svnTempFile
[[ -f $svnTempError ]] && rm $svnTempError

cd $svnDir
echo "svn status.."
svn st > $svnTempFile

needSvn=false
if [[ -s $svnTempFile ]];then
	needSvn=true
else
	echo "没有需要提交的文件，终止"
fi

if($needSvn);then
{
	cat $svnTempFile | while read line
	do 
		echo $line
		checkSvn $line
	done

	if [[ "$commitM"x == ""x ]];then
		echo "====写注释：====="
		read
		commitM=$REPLY
	fi
	echo "svn commit -m "$commitM >> $svnTempFileRun

	chmod +x $svnTempFileRun
	echo "====>svn commit begin"
	sh $svnTempFileRun
}
fi

rm $svnTempFile
rm $svnTempFileRun