sudo gsutil cp gs://my-poc-dilip/cloud-sql-proxy /opt
#sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
#sudo yum -y install postgresql12-server
export NIC1_GW=$(/bin/curl -s -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/gateway" )
echo $NIC1_GW

sudo cat > /opt/routing.sh <<'EOF'
#!/usr/routing.sh
echo "Updating linux kernel routing table"
sudo route add -net 10.128.0.0/16 gw ${NIC1_GW}
route -n
if [ $? -eq 0 ]; then
   echo "Linux kernel routing added successfully"
else
   echo "Linux kernel routle table already updated"
fi
EOF
sudo chmod 755 /opt/routing.sh
cat > /etc/systemd/system/routing.service << 'EOF'
[Unit]
Description=routig service to enable conection to postgre smachine
Wants=local-fs.target network-online.target network.target
[Service]
Type=Simple
User=root
Group=root
ExecStart=/opt/routing.sh
StandardOutput=syslog
StandardError=syslog
Restart=always
RestartSec=15
[Install]
WantedBy=multi-user.target
EOF

sudo chmod 755 /opt/cloud-sql-proxy

cat /etc/systemd/system/cloudsql_auth_proxy_automatic.service <<'EOF'
[Unit]
Description= cloud proxy service
After=routing.service
Wants=local-fs.target network-online.target network.target
[Service]
Type=Simple
User=root
Group=root
ExecStart=/opt/cloud-sql-proxy -instance=my-poc-dilip:us-central1:quickstart-vm-instance1=tcp:0.0.0.0:3307 -ip_address_types=PRIVATE
ExecStart=/opt/cloud-sql-proxy --auto-iam-authn --address 0.0.0.0 --port 3307 --private-ip  my-poc-dilip:us-central1:mnqs
StandardOutput=syslog
StandardError=syslog
Restart=always
RestartSec=15
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable routing.service
sudo systemctl enable cloudsql_auth_proxy_automatic.service
sudo systemctl daemon-reload
sudo systemctl start routing.service
sudo systemctl start cloudsql_auth_proxy_automatic.service

sudo systemctl status routing.service
sudo systemctl status cloudsql_auth_proxy_automatic.service
