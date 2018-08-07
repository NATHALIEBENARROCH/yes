#!/usr/bin/env bash
set -x
echo "Trying to deploy the branch ${BRANCH_NAME}"

#
### Access the working dir and render the files
# 
cd $WORKSPACE

if [[ "v2" == "${BRANCH_NAME}" ]]; then
	/usr/bin/make
	ssh srv1.enlightns.ca "rm -rf /srv/apps/staging/beta.jdlabs.co/*; mkdir -p /srv/apps/staging/beta.jdlabs.co/{en,fr}"
	/usr/bin/rsync -azvh en/public srv1.enlightns.ca:/srv/apps/staging/beta.jdlabs.co/en
	/usr/bin/rsync -azvh fr/public srv1.enlightns.ca:/srv/apps/staging/beta.jdlabs.co/fr
	/usr/bin/rsync -azvh beta.jdlabs.co.conf srv1.enlightns.ca:/srv/apps/staging/beta.jdlabs.co/
	ssh srv1.enlightns.ca "sudo cp /srv/apps/staging/beta.jdlabs.co/beta.jdlabs.co.conf /etc/nginx/sites-available/beta.jdlabs.co.conf; sudo systemctl reload nginx.service"
elif [[ "prod" == "${BRANCH_NAME}" ]]; then
	# Change the baseURL to www.jdlabs.co
	sed -i 's/beta/www/g' */config.yaml
	/usr/bin/make
	ssh srv1.enlightns.com "rm -rf /srv/apps/production/www.jdlabs.co/*; mkdir -p /srv/apps/production/www.jdlabs.co/{en,fr}"
	/usr/bin/rsync -azvh en/public srv1.enlightns.com:/srv/apps/production/www.jdlabs.co/en
	/usr/bin/rsync -azvh fr/public srv1.enlightns.com:/srv/apps/production/www.jdlabs.co/fr
	/usr/bin/rsync -azvh www.jdlabs.co.conf srv1.enlightns.com:/srv/apps/production/www.jdlabs.co/
	ssh srv1.enlightns.com "sudo cp /srv/apps/production/www.jdlabs.co/www.jdlabs.co.conf /etc/nginx/sites-available/www.jdlabs.co.conf; sudo systemctl reload nginx.service"
else
    echo "Your branch has not been configured for deployment: ${BRANCH_NAME}"
fi

