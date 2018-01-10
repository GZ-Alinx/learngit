#!/bin/bash
#
date=`date +%Y%m%d`
for=`find /data/dataTemp/resource_files/harvest/ -name "$date*" > /root/$date.txt`
#
#echo $?
#	if [ -eq 0 ];then
#	echo "~~~~~~ok~~~~~~~"
#	else
#	$for
#	fi	
