from debian:jessie

MAINTAINER "Dylan Lindgren" <dylan.lindgren@gmail.com>

WORKDIR /tmp

# Install the version of Nginx in the Debian Jessie repository
RUN apt-get update -y && \
    apt-get install -y nginx

# Apply Nginx configuration
ADD config/nginx.conf /opt/etc/nginx.conf

# Copy in the Nginx startup script and make it executable
ADD config/nginx-start.sh /opt/bin/nginx-start.sh
RUN chmod u=rwx /opt/bin/nginx-start.sh

RUN mkdir -p /data/www
VOLUME ["/data/www"]

EXPOSE 80 443

WORKDIR /opt/bin

ENTRYPOINT ["nginx-start.sh"]