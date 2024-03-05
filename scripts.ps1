#!/bin/bash
sudo mkdir /home/packerizer
# Install Apache (httpd) and other necessary packages
sudo yum install httpd -y

# Start Apache and enable it to start on boot
sudo systemctl start httpd
sudo systemctl enable httpd

# Setup directory
sudo mkdir /var/www/html/php

cd /var/www/html/php

# Copy over build artifacts
sudo cp -r /tmp/ _tanujthakur005_php_code/* .

# Set proper permissions for Apache to access the directory
sudo chown -R apache:apache /var/www/html/php
sudo chmod -R 755 /var/www/html/php

# Create Apache virtual host configuration
echo "
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/php
    <Directory /var/www/html/php>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
" | sudo tee /etc/httpd/conf.d/php.conf

# Open firewall port for HTTP (80)
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

# Restart Apache to apply changes
sudo systemctl restart httpd

# Clean up buildArtifacts directory
rm -rf /var/buildArtifacts/*


# Note: Depending on your specific CentOS version, you might need to adjust some commands or paths.
