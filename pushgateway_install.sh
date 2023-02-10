#!/bin/bash
VERSION="1.4.3"

wget https://github.com/prometheus/pushgateway/releases/download/v${VERSION}/pushgateway-${VERSION}.linux-amd64.tar.gz
 
tar -xzvf pushgateway-${VERSION}.linux-amd64.tar.gz
cd pushgateway-${VERSION}.linux-amd64
cp pushgateway /usr/local/bin

# create user
useradd --no-create-home --shell /bin/false pushgateway

chown pushgateway:pushgateway /usr/local/bin/pushgateway

echo '[Unit]
Description=pushgateway
Wants=network-online.target
After=network-online.target

[Service]
User=pushgateway
Group=pushgateway
Type=simple
ExecStart=/usr/local/bin/pushgateway

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/pushgateway.service

# enable pushgateway in systemctl
systemctl daemon-reload
systemctl start pushgateway
systemctl enable pushgateway
##################################################

echo "Setup complete.
Add the following lines to /etc/prometheus/prometheus.yml:

  - job_name: 'pushgateway'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9091']
"

