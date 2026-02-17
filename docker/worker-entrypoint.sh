#!/bin/bash

printenv >> /etc/environment

cd /var/www/html

./bin/cake queue worker