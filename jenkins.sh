#!/usr/bin/env bash
set -x
echo "Trying to deploy the branch ${BRANCH_NAME}"

#
### Access the working dir and render the files
# 
cd $WORKSPACE
/usr/bin/make

if [[ "v2" == "${BRANCH_NAME}" ]]; then
	ssh http.enlightns.ca "rm -rf /srv/apps/staging/beta.jdlabs.co/*"
	ssh http.enlightns.ca "mkdir -p /srv/apps/staging/beta.jdlabs.co/{en,fr}"
	/usr/bin/rsync -azvh en/public http.enlightns.ca:/srv/apps/staging/beta.jdlabs.co/en
	/usr/bin/rsync -azvh fr/public http.enlightns.ca:/srv/apps/staging/beta.jdlabs.co/fr
	/usr/bin/rsync -azvh beta.jdlabs.co.conf http.enlightns.ca:/srv/apps/staging/beta.jdlabs.co/
	ssh http.enlightns.ca "sudo cp /srv/apps/staging/beta.jdlabs.co/beta.jdlabs.co.conf /etc/nginx/sites-available/beta.jdlabs.co.conf"
elif [[ "prod" == "${BRANCH_NAME}" ]]; then
	ssh http.enlightns.ca "rm -rf /srv/apps/production/www.jdlabs.co/*"
	ssh http.enlightns.ca "mkdir -p /srv/apps/production/www.jdlabs.co/{en,fr}"
	/usr/bin/rsync -azvh en/public http.enlightns.ca:/srv/apps/production/www.jdlabs.co/en
	/usr/bin/rsync -azvh fr/public http.enlightns.ca:/srv/apps/production/www.jdlabs.co/fr
	/usr/bin/rsync -azvh www.jdlabs.co.conf http.enlightns.ca:/srv/apps/production/www.jdlabs.co/
	ssh http.enlightns.ca "sudo cp /srv/apps/production/www.jdlabs.co/www.jdlabs.co.conf /etc/nginx/sites-available/www.jdlabs.co.conf"
else
    echo "YOur branch has not been configured for deployment: ${BRANCH_NAME}"
fi
ssh http.enlightns.ca "sudo systemctl reload nginx.service"

