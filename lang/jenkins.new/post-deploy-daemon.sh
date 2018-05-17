#!/bin/bash

branch_name=$1
branch_name=${branch_name:7}

sudo chown -R deploy:deploy /data/daemon/releases/$branch_name
cd /data/daemon/releases/$branch_name
su -c "/usr/bin/composer install" deploy

mv /data/daemon/releases/$branch_name/API/public/index-prod.php /data/daemon/releases/$branch_name/API/public/index.php
mv /data/daemon/releases/$branch_name/admin/public/index-prod.php /data/daemon/releases/$branch_name/admin/public/index.php
mv /data/daemon/releases/$branch_name/console/index-prod.php /data/daemon/releases/$branch_name/console/index.php

chown -R nobody:nobody /data/daemon/releases/$branch_name
ln -sfn /data/daemon/releases/$branch_name /data/daemon/releases/current-temp
mv -fT /data/daemon/releases/current-temp /data/daemon/releases/current

mv -f /data/daemon/releases/current/push/src/config/config.prod /data/daemon/releases/current/push/src/config/config.go
systemctl reload php72-php-fpm

