#!/bin/bash
#
##mysql bankup script
cat << EOF 
备份脚本须知：
	备份数据需要注意备份空间！
	备份数据需要注意安全防护！
	备份数据需要周期化的操作！
	备份数据切记做好异地备份！
EOF
#请等待-------
st=$(date +%s)  
USER="root"   
PASSWORD="*chatong8yw"   
DATABASE="mysql"
MAIL="itadminlx.@163.com.com"
BACKUP_DIR=/data/bankup/mysql #备份文件存储路径   
LOGFILE=/data/bankup/mysql/data_backup.log #日志文件路径  
   
DATE=`date +%Y%m%d-%H%M`
DUMPFILE=$DATABASE$DATE.sql   
ARCHIVE=$DATABASE$DATE.sql.tar.gz   
OPTIONS="-u$USER -p$PASSWORD $DATABASE"  
  
#判断备份文件存储目录是否存在，否则创建该目录   
if [ ! -d $BACKUP_DIR ]   
then  
    mkdir -p "$BACKUP_DIR"  
fi    
  
#开始备份之前，将备份信息头写入日记文件   
echo "    ">> $LOGFILE   
echo "--------------------" >> $LOGFILE   
echo "BACKUP DATE:" $(date +"%y-%m-%d %H:%M:%S") >> $LOGFILE   
echo "-------------------" >> $LOGFILE    
  
#切换至备份目录   
cd $BACKUP_DIR   
mysqldump $OPTIONS > $DUMPFILE   
#判断数据库备份是否成功   
if [[ $? == 0 ]]  
then   
    tar czvf $ARCHIVE $DUMPFILE >> $LOGFILE 2>&1   
    echo "[$ARCHIVE] Backup Successful! 备份成功！" >> $LOGFILE   
#    rm -f $DUMPFILE #删除原始备份文件,只需保留备份压缩包  
    # 把压缩包文件备份到其他机器上。  
#    scp  $BACKUP_DIR$ARCHIVE root@*.*.*.*:/home/user/data_backup/ >> $LOGFILE  2>&1  
 else   
    echo "Database Backup Fail! 备份失败！" >> $LOGFILE   
#备份失败后向管理者发送邮件提醒   
#mail -s "database:$DATABASE Daily Backup Fail!备份出问题了！" $MAIL   
fi   
echo "Backup Process Done 结束备份！"   
#删除3天以上的备份文件  
#Cleaning  
#find $BACKUP_DIR  -type f -mtime +2 -name "*.tar.gz" -exec rm -f {} \;  
