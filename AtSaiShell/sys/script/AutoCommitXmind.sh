#!/bin/bash
# @auther atany
FilePath="/Users/yangguang/GitHub/AndroidXmind/Android-xmind-"
FileName="Android.xmind"
FileAbsPath="$FilePath"/"$FileName"
echo "Commit "$FileAbsPath
cd $FilePath
git add $FileName
git commit -m "commit xmind file"
git push origin master