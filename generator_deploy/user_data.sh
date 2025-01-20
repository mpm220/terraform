#!/bin/bash
set -e

# Ensure network and metadata service are ready
until curl -s http://169.254.169.254/latest/meta-data/ > /dev/null; do
echo "Waiting for network and metadata service..."
sleep 5
done

# Update and install dependencies
yum update -y
yum install -y httpd p7zip p7zip-plugins

# Start Apache web server
systemctl start httpd
systemctl enable httpd

# Download the React application
mkdir -p /var/www/html
# Loop until the file is downloaded successfully
until /usr/bin/curl -o /tmp/app.7z https://storage-for-dummy-generator-2025-01-19.s3.eu-west-2.amazonaws.com/app.7z && [ -f /tmp/app.7z ]; do
echo "File download failed. Retrying..."
sleep 5  # wait for 5 seconds before retrying
done

echo "File downloaded successfully"

# Extract the React app
/usr/bin/7z x /tmp/app.7z -o/var/www/html

# Check if extraction was successful
if [ "$(ls -A /var/www/html)" ]; then
echo "Extraction successful"
else
echo "Extraction failed. Exiting..." >&2
exit 1
fi

# Set permissions for Apache
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Ensure Apache serves the correct files by checking the configuration
echo "Configuring Apache to serve React app"
echo "DirectoryIndex index.html" >> /etc/httpd/conf/httpd.conf

# Restart Apache to serve the React app
systemctl restart httpd
