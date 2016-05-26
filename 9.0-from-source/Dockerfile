FROM debian:jessie
MAINTAINER Odoo S.A. <info@odoo.com>

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
            node-less \
            node-clean-css \
            python-pyinotify \
            python-renderpm \
            python-support \
        && curl -o wkhtmltox.deb -SL http://nightly.odoo.com/extra/wkhtmltox-0.12.1.2_linux-jessie-amd64.deb \
        && echo '40e8b906de658a2221b15e4e8cd82565a47d7ee8 wkhtmltox.deb' | sha1sum -c - \
        && dpkg --force-depends -i wkhtmltox.deb \
        && apt-get -y install -f --no-install-recommends \
        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false npm \
        && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# Install Odoo
ENV ODOO_VERSION 9.0
ENV ODOO_RELEASE 20160204
#RUN set -x; \
#        curl -o odoo.deb -SL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}c.${ODOO_RELEASE}_all.deb \
#        && echo '3633f30901619bfaeb12bb6cbb0de770856c5db6 odoo.deb' | sha1sum -c - \
#        && dpkg --force-depends -i odoo.deb \
#        && apt-get update \
#        && apt-get -y install -f --no-install-recommends \
#        && rm -rf /var/lib/apt/lists/* odoo.deb

### START For using source install only
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
        	npm \
        	gcc \
        	python-pip \
		python-dev \
		libpq-dev \
		libxml2-dev \
		libxslt-dev \
		libevent-dev \
		libsasl2-dev \
		libldap2-dev \
		libjpeg-dev \
# Added missing components to have a successful build with pip later
		libxml2 \
		libxslt1.1 \
		python-libxml2 \
		python-libxslt1 \
		python-dev

# As per instruction from https://www.odoo.com/documentation/9.0/setup/install.html#setup-install-source
RUN set -x; \
        npm install -g less less-plugin-clean-css

COPY ./requirements.txt /

# As per instruction from https://www.odoo.com/documentation/9.0/setup/install.html#setup-install-source
RUN set -x; \
        pip install -r /requirements.txt

# useful tools
RUN set -x; \
        apt-get install -y --no-install-recommends \
            nano			
# As per instruction from https://www.odoo.com/documentation/9.0/setup/install.html#setup-install-source
RUN set -x; \
		ln -s /usr/bin/nodejs /usr/bin/node

### END For using source install only

RUN useradd -Ums /bin/bash odoo
# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./openerp-server.conf /etc/odoo/
RUN chown odoo /etc/odoo/openerp-server.conf

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons \
        && chown -R odoo /mnt/extra-addons
RUN mkdir -p /mnt/odoo \
        && chown -R odoo /mnt/odoo
RUN mkdir -p /var/lib/odoo \
        && chown -R odoo /var/lib/odoo
VOLUME ["/var/lib/odoo", "/mnt/extra-addons", "/mnt/odoo"]

# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
ENV OPENERP_SERVER /etc/odoo/openerp-server.conf

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
#CMD ["openerp-server"]
CMD ["python", "/mnt/odoo/odoo.py", "-w", "odoo", "-r", "odoo", "--db_host=odoo-db"]
#CMD ["/bin/bash"]
