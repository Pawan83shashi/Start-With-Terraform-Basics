#!/bin/bash
sudo yum update
sudo install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1> Deployment through Terraform </h1>" | sudo tee /var/www/html/index.html