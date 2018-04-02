#!/bin/bash

branch_name=$1
branch_name=${branch_name:4}

sudo chown -R deploy:deploy /data/releases/$branch_name
cd /data/releases/$branch_name
su -c "/usr/bin/composer install" deploy

mv /data/releases/$branch_name/API/public/index-prod.php /data/releases/$branch_name/API/public/index.php
mv /data/releases/$branch_name/admin/public/index-prod.php /data/releases/$branch_name/admin/public/index.php
mv /data/releases/$branch_name/console/index-prod.php /data/releases/$branch_name/console/index.php

chown -R nobody:nobody /data/releases/$branch_name
ln -sfn /data/releases/$branch_name /data/releases/current-temp
mv -fT /data/releases/current-temp /data/releases/current

systemctl reload php72-php-fpm

