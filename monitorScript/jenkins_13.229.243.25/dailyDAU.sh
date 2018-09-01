#!/bin/bash

#
#  nobody 身份跑
#

file='/data/log/logstash/nginx/api.access.log'
echo '文件为:'$file
today=`date -d 'yesterday' +%d`
echo '今天为:'$today
dailyDAU=`awk '$7 ~ /^\['$today'/' $file  | awk '$17 ~ /.{20,}/ {print $17}' | sort -n | uniq | wc -l`

date=`date`
echo $date ' 日活为:'$dailyDAU

URL="https://api.gamelanglive.com/internal/dailyCount"

response=`curl -d "dailyDAU=$dailyDAU" $URL`
echo $response