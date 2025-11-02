#!/bin/bash
cd /home/ubuntu
sudo apt update -y
sudo apt install -y python3 python3-pip git make

git clone https://github.com/andreaendigital/CarPricePredictor-Demo.git
cd CarPricePredictor-Demo

# Complete setup
make setup

# Start in background with logging
nohup make dev-python > /var/log/carprice.log 2>&1 &

# Wait for services to start
sleep 30

echo "Services started. Check logs: tail -f /var/log/carprice.log"
echo "Access: http://$(curl -s ifconfig.me):3000"
