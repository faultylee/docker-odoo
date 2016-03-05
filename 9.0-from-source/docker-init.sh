#!/bin/bash
#docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name odoo-db postgres
docker run -d -p 8069:8069 --name odoo --link odoo-db:db -v /home/faulty/build/docker-odoo/9.0/odoo:/mnt/odoo -v /home/faulty/build/docker-odoo/9.0/lib_odoo:/var/lib/odoo -v /home/faulty/build/docker-odoo/9.0/extra-addons:/mnt/extra-addons -t odoo
