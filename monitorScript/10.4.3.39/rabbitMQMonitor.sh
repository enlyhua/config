#!/bin/bash

#
# jianhua 身份跑
#

date=`date`
echo $date

URL="https://api.gamelanglive.com/internal/Monitor/rabbit"

maxNum=100

for QUEUE in $(sudo rabbitmqctl list_queues |grep -v 'Listing queues ...' | awk -F' ' '{print $1}');
do
        echo $QUEUE
        num=$(sudo rabbitmqctl list_queues |grep $QUEUE | awk -F' ' '{print $2}')

        if [ $num -gt $maxNum ]; then
                echo '大于'
                response=`curl -d "queue=$QUEUE&num=$num" $URL`
                echo $response
        else
                echo '小于'
        fi
done