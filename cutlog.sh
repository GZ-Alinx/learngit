#!/bin/bash
date=$(date +%Y%m%d -d -1day)
cd /www/wdlinux/nginx/logs/
if [ ! -d cut ] ; then
        mkdir cut
fi
mv alinx.com_access.log cut/www.alinx.com-access_$(date +%Y%m%d -d -1day).log
mv alinx.com_error.log cut/www.alinx.com-error_$(date +%Y%m%d -d -1day).log
service nginxd stop && service nginxd start && service nginxd status
if [ $? -eq 0 ];then
         echo "`date`_logcut done/nginxd.log
fi
