#!/usr/bin/env bash
set -x

mkdir -p /srv/apps/production/jdlabs.co.contact/api
sudo chown d2s3admin. /srv/apps/production/jdlabs.co.contact/api
cp /srv/apps/production/www.jdlabs.co/index.php /srv/apps/production/jdlabs.co.contact/api
sudo cp /srv/apps/production/www.jdlabs.co/www.jdlabs.co.conf /etc/nginx/sites-available/www.jdlabs.co.conf
sudo systemctl reload nginx.service