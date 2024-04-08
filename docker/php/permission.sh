#!/bin/bash

# Change directory to /var/www/html
cd /var/www/html || exit

# Run chmod command for bootstrap and storage folder
chmod 777 -R bootstrap storage
