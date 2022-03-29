#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
    sleep 1
done

# install nginx
sudo yum install update
#sudo yum -y install nginx
sudo amazon-linux-extras install nginx1

# make sure nginx is started
sudo service nginx start