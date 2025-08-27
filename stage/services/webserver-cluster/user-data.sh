#!/bin/bash
set -xe
# Install Apache using yum
yum install -y httpd

# Enable and start Apache
systemctl start httpd
systemctl enable httpd


# Create simple index.html
cat > /var/www/html/index.html <<EOF
<h1>Hello, World</h1>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF