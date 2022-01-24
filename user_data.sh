#!/bin/bash
yum -y update
yum -y install httpd
service httpd start
chkconfig httpd on
echo "Hello $(hostname -f), Build by Terraform Cloud using external file" > /var/www/html/index.html
