#!/bin/bash -e

# upgrade system
add-apt-repository --yes ppa:brightbox/ruby-ng
add-apt-repository --yes ppa:chris-lea/node.js
apt-get update
apt-get upgrade --yes
apt-get install --yes git

# install ruby
apt-get update
apt-get install --yes ruby2.1 ruby2.1-dev bundler
apt-get install --yes libghc-zlib-dev

# install nodejs
apt-get update
apt-get install --yes nodejs

# install and configure nginx
apt-get install --yes nginx
rm /etc/nginx/sites-enabled/default
cp /vagrant/_vagrant/nginx.conf /etc/nginx/sites-available/epages-docs
ln -s /etc/nginx/sites-{available,enabled}/epages-docs
sed -i 's/sendfile on/sendfile off/' /etc/nginx/nginx.conf
service nginx restart

# install elasticsearch
apt-get install openjdk-7-jre-headless -y
cd /tmp
wget --quiet https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.deb
dpkg -i elasticsearch-1.4.4.deb
sed -i 's/#cluster\.name: elasticsearch/cluster.name: epages-docs/' /etc/elasticsearch/elasticsearch.yml
update-rc.d elasticsearch defaults 95 10
/etc/init.d/elasticsearch start

# clone and build jekyll stuff
cd /vagrant
bundle
LC_ALL=en_US.UTF-8 jekyll build
LC_ALL=en_US.UTF-8 jekyll index

exit 0
