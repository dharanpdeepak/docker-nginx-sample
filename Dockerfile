# Docker Nginx Container

# Base Image
From ubuntu:14.04

# Author
Maintainer Deepak Dharan Padmini

# Essentials - update repos, install net-tools
RUN apt-get update
run apt-get install -y net-tools

# Download & Install and Nginx
RUN apt-get install -y nginx

# Remove default Nginx conf file
RUN rm -vf /etc/nginx/nginx.conf

# Create Directories required
RUN mkdir -p /var/log/nginx/
RUN mkdir -p /opt/static/
RUN mkdir -p /etc/nginx/certs/

# Copy-over custom config files
ADD config/nginx.conf /etc/nginx/
ADD config/site.conf /etc/nginx/conf.d/nginx.conf
RUN rm -rf /etc/nginx/sites-enabled/default

# Copy cert files
ADD config/certs/site.crt /etc/nginx/certs/site.crt
ADD config/certs/site.key /etc/nginx/certs/site.key

# Copy Static Content
ADD webroot/static /opt/static/

# Avoid stalling issues by adding daemonoff
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose ports
EXPOSE 443
EXPOSE 80

# start Nginx
CMD service nginx start
