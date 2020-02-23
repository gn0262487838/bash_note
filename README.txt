# Program:
#         寫一個可以不用進docker就可以直接撈取音檔,音檔log和音檔時間註記並壓縮成zip或打包tar
#         此外額外備份sql跟upload file。
# History:
#         20200222 jack first release
#         copy.sh need to under /mnt/kaldi_models/
#         /opt/models/ docker裡面資料夾映射到客戶機路徑 /mnt/kaldi_models/
# Output:
# 	      1. FolderName.zip
#         2. sql.zip
#         3. upload.tar
#
# First settings:
# 	      step1. sudo su
# 	      step2. cp /media/kenkone/隨身碟名稱/scripts/copy.sh /mnt/kaldi_models/
# 	      step3. cp /media/kenkone/隨身碟名稱/scripts/bk_start.sh /mnt/
# Back Up Step:
# 	      step1. sudo su
# 	      step2. docker ps
# 	      step3. sh bk_start.sh containerID FolderName minute
#         step4. cp /mnt/FolderName.zip /media/kenkone/隨身碟名稱/ && cp /mnt/sql.zip /media/kenkone/隨身碟名稱/ && cp /mnt/upload.tar /media/kenkone/隨身碟名稱/
#
#    	    *example: sh bk_start.sh 4b7 20200224_test 16000
# 	      *分鐘指的是從現在到過去的分鐘，故要抓三天前的資料，就輸入4320分鐘(60X24X3)。