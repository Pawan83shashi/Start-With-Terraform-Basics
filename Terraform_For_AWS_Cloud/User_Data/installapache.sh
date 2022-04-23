#! /bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
    sleep 1
done

sudo yum update
sudo yum install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Deployed Machine via Terraform</h1>" | sudo tee /var/www/html/index.html