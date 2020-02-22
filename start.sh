#!/bin/bash
# program:
#         寫一個可以不用進docker就可以直接撈取音檔,音檔log和音檔時間註記
# History:
#         20200222 jack first release
#         copy.sh need to under /mnt/kaldi_models/
#         /opt/models/ docker裡面資料夾映射到客戶機路徑 /mnt/kaldi_models/
# param:
#       $1:docker container ID
#       $2:Folder Name
#       $3:minute from now to before

# check and get var
if [ -z "$1" ]
then
    echo "please input first argu: container ID"
    exit
fi

if [ -z "$2" ]
then
    echo "please input second argu: Folder Name"
    exit
fi

if [ -z "$3" ]
then
    echo "please input third argu: minute"
    exit
fi

containerID=$1
folderName=$2
minute_=$3
echo "containerID folderName minute_ : $@"


# zip folder
value_=0
echo "test copy.sh..."
test -f /mnt/kaldi_models/copy.sh && value_=1 || echo "missing /mnt/kaldi_models/copy.sh"

if [ $value_ = 1 ]
then
    echo "zipping...audio, sql and upload file"
    docker exec -it $containerID /bin/bash -c "sh /opt/models/copy.sh $folderName $minute_" && zip -r -m /mnt/$folderName.zip /mnt/kaldi_models/$folderName/*
    rm -r /mnt/kaldi_models/$folderName/
    zip -r /mnt/sql.zip /mnt/Kingcolon/server/sql/*
    tar -cf /mnt/upload.tar /mnt/Kingcolon/server/public/upload/*
    echo "zip completed"
    exit 0
fi