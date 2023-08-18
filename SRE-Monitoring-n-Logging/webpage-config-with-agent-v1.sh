#!/bin/bash

# Download script to add agent as repository, then update repositories

#curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
#sudo bash add-monitoring-agent-repo.sh
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install
sudo apt update

# Install and configure Apache with custom web page
sudo apt install apache2 -y

sudo mkdir /var/www/html/images
mkdir images
gsutil -m cp -r gs://acg-gcloud-course-resources/network-engineer/cdn/images/*  images/
sudo cp images/*  /var/www/html/images



sudo cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>DEMO WEB PAGE</title>
    </head>
    <body>
        
        <h1>Welcome to your demonstration website</h1>
        <br>
        <img src='images/icon_cloud.png' width='30%'>
EOF

# Install the latest version of the agent
#sudo apt-get install stackdriver-agent -y

# Download apache.conf and place it in the directory /opt/stackdriver/collectd/etc/collectd.d/:

#(cd /opt/stackdriver/collectd/etc/collectd.d/ && sudo curl -O https://raw.githubusercontent.com/Stackdriver/stackdriver-agent-service-configs/master/etc/collectd.d/apache.conf)

# Restart the monitoring agent:

#sudo service stackdriver-agent restart