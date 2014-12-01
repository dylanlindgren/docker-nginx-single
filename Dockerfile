from debian:jessie

MAINTAINER "Dylan Lindgren" <dylan.lindgren@gmail.com>

WORKDIR /tmp

# Install the version of Nginx in the Debian Jessie repository
RUN apt-get update -y && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Apply Nginx configuration
ADD config/nginx.conf /opt/etc/nginx.conf
RUN rm /etc/nginx/sites-enabled/default

# Copy in the Nginx startup script and make it executable
ADD config/nginx-start.sh /opt/bin/nginx-start.sh
RUN chmod u=rwx /opt/bin/nginx-start.sh

RUN mkdir -p /data/www
VOLUME ["/data/www"]

RUN mkdir -p /data/log
VOLUME ["/data/log"]

EXPOSE 80 443

WORKDIR /opt/bin

ENTRYPOINT ["/opt/bin/nginx-start.sh"]