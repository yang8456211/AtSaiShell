#!/bin/bash
# @auther atany

usage(){
cat << ENTER
    ==============    AutoCommitXind to git     ==============
        作用:AutoCommitXind to git 
        使用:./AutoCommitXind go
    ==============     AutoCommitXind to git      ==============
ENTER
}

if [ $# -ne 1 ];then 
    usage 
    exit 127
fi

opt=$1
if [[ $opt == "go" ]];then    

	FilePath="/Users/yangguang/GitHub/AndroidXmind/Android-xmind-"
	FileName="Android.xmind"
	FileAbsPath="$FilePath"/"$FileName"
	echo "Commit "$FileAbsPath
	cd $FilePath
	git add $FileName
	git commit -m "commit xmind file"
	git push origin master
else
	echo "==> Error Agr"
	usage
fi