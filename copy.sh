#!/bin/bash
# Program:
#         copy audio, worker log and timestamp to /opt/models/
# History:
# 20200222 jack First release
# param:
#       $1:Folder Name
#       $2:minute from now to before

# check and get var
if [ -z "$1" ]
then
    echo "please input first argu: Folder Name"
    exit
fi

if [ -z "$2" ]
then
    echo "please input second argu: Minute"
    exit
fi

foldername=$1
minute=$2

echo "var file name $foldername"
echo "var mmin $minute"

# 找尋分鐘內的音檔並把它們放到models底下的資料夾，因為它跟外面映射的接口在此。
value=0
test -d /opt/models/$foldername && value=1 || echo "path not exits"
if [ $value = 0 ]
then
    echo "make path $foldername" && mkdir /opt/models/$foldername
    value=1
fi

if [ $value = 1 ]
then
    echo "Copy Audio..." && find /opt/tmp/* -mmin -$minute -exec cp {} /opt/models/$foldername \;

    # 列出檔案清單時間並手動copy至記事本，因為你上面找到的檔案時間資料都被統一化了。
    cd /opt/tmp/

    echo "Create Time Stamp..." && ls -ltr --full-time > /opt/models/$foldername/${foldername}_FileTimeStamp.txt && cp /opt/worker.log /opt/models/$foldername

    echo "All processing completed"
    exit 0
else
    echo "something was error..."
    exit 0
fi