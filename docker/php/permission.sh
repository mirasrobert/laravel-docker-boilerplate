#!/bin/bash

# Change directory to /var/www/html
cd /var/www/html || exit

find . -type f -exec chmod 664 {} \;   
find . -type d -exec chmod 775 {} \;

# Run chmod command for bootstrap and storage folder
chown -R $USER:www-data bootstrap/cache
chown -R $USER:www-data storage

chmod -R 775 bootstrap/cache storage
