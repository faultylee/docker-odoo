About this Repo
======

This is the forked Git repo from the official Docker image for [Odoo](https://registry.hub.docker.com/_/odoo/). The reason is to add ability to run Odoo [from source](https://www.odoo.com/documentation/9.0/setup/install.html#setup-install-source)


Usage
======

To run the community version of `odoo` from source, clone from https://github.com/odoo/odoo.git


Execute this command to create a container named `odoo-db` running the `latest` postgres
```
sudo docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name odoo-db postgres
```

Then to start `odoo` by executing this command
```
sudo docker run -it --name odoo --link odoo-db:db -p 8069:8069 -v /path-to-odoo-source/odoo:/mnt/odoo odoo:test
```
\* This will link to `odoo-db`, map the locally cloned `odoo` source code into `\mnt\odoo` and create a container named `odoo`
