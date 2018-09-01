#!/bin/bash

branch_name=$1
branch_name=${branch_name:4}

sudo chown -R deploy:deploy /data/api/releases/$branch_name
cd /data/api/releases/$branch_name
su -c "/usr/bin/composer install" deploy

mv /data/api/releases/$branch_name/API/public/index-prod.php /data/api/releases/$branch_name/API/public/index.php
mv /data/api/releases/$branch_name/admin/public/index-prod.php /data/api/releases/$branch_name/admin/public/index.php
mv /data/api/releases/$branch_name/console/index-prod.php /data/api/releases/$branch_name/console/index.php

chown -R nobody:nobody /data/api/releases/$branch_name
ln -sfn /data/api/releases/$branch_name /data/api/releases/current-temp
mv -fT /data/api/releases/current-temp /data/api/releases/current

systemctl reload php72-php-fpm

