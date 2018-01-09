#!/bin/bash
#
read -p "please input database:" DB
read -p "please ibput password:" PASS
mysqldump -uroot -p$PASS $DB > $DB`date`
