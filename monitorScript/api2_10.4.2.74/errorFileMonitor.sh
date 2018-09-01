#!/bin/bash

#
# jianhua 身份运行
#

date=`date`

echo $date

apiNode=2
pwd=`pwd`

# api error log

echo 'nginx api error log monitor'

apiErrorLogFile='/data/log/nginx/api.error.log'
apiErrorLogSize=`sudo wc -c $apiErrorLogFile | awk '{print $1}'`
echo $apiErrorLogSize
apiSize='/data/monitorScript/apiErrorLog.size'
size=`cat $apiSize`
echo $size

if [ -z "$size" ];then
        echo '文件为空'
        `echo $apiErrorLogSize > $apiSize`
elif [ $apiErrorLogSize -gt ${size} ];then
        echo '大于'
        `echo $apiErrorLogSize > $apiSize`
        `/usr/bin/php72 /data/daemon/releases/current/console/index.php Monitor/ApiLogError ${apiNode} `
else
        echo '小于'
fi


# nginx error log

echo 'nginx error log monitor'

nginxErrorLogFile='/var/log/nginx/error.log'
nginxErrorLogSize=`sudo wc -c $nginxErrorLogFile | awk '{print $1}'`
echo $nginxErrorLogSize
nginxSize='/data/monitorScript/nginxErrorLog.size'
size=`cat $nginxSize`
echo $size

if [ -z "$size" ];then
        echo '文件为空'
        `echo $nginxErrorLogSize > $nginxSize`
elif [ $nginxErrorLogSize -gt ${size} ];then
        echo '大于'
        `echo $nginxErrorLogSize > $nginxSize`
        `/usr/bin/php72 /data/daemon/releases/current/console/index.php Monitor/NginxLogError ${apiNode} `
else
        echo '小于'
fi

# php-fpm global error

echo 'php-fpm global error log monitor'

phpFpmGlobalErrorLogFile='/data/log/php/php-fpm-error.log'
phpFpmGlobalErrorLogSize=`sudo wc -c $phpFpmGlobalErrorLogFile | awk '{print $1}'`
echo $phpFpmGlobalErrorLogSize
phpFpmGlobalSize='/data/monitorScript/phpFpmGlobalErrorLog.size'
size=`cat $phpFpmGlobalSize`
echo $size

if [ -z "$size" ];then
        echo '文件为空'
        `echo $phpFpmGlobalErrorLogSize > $phpFpmGlobalSize`
elif [ $phpFpmGlobalErrorLogSize -gt ${size} ];then
        echo '大于'
        `echo $phpFpmGlobalErrorLogSize > $phpFpmGlobalSize`
        `/usr/bin/php72 /data/daemon/releases/current/console/index.php Monitor/PhpFpmGloalError ${apiNode} `
else
        echo '小于'
fi


# php-fpm api error

echo 'php-fpm api error log monitor'

phpFpmApiErrorLogFile='/data/log/php/api-error.log'
phpFpmApiErrorLogSize=`sudo wc -c $phpFpmApiErrorLogFile | awk '{print $1}'`
echo $phpFpmApiErrorLogSize
phpFpmApiSize='/data/monitorScript/phpFpmApiErrorLog.size'
size=`cat $phpFpmApiSize`
echo $size

if [ -z "$size" ];then
        echo '文件为空'
        `echo $phpFpmApiErrorLogSize > $phpFpmApiSize`
elif [ $phpFpmApiErrorLogSize -gt ${size} ];then
        echo '大于'
        `echo $phpFpmApiErrorLogSize > $phpFpmApiSize`
        `/usr/bin/php /data/daemon/releases/current/console/index.php Monitor/PhpFpmPoolError ${apiNode} `
else
        echo '小于'
fi
