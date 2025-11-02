#!/bin/bash
cd /home/ubuntu
sudo apt update -y
sudo apt install -y python3 python3-pip python3-venv git make

git clone https://github.com/andreaendigital/CarPricePredictor-Demo.git
cd CarPricePredictor-Demo

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install with --break-system-packages as fallback
pip install -e .[dev] --break-system-packages || pip install -e .[dev]

# Start the app directly
nohup python3 -m flask run --host=0.0.0.0 --port=5000 > /var/log/carprice.log 2>&1 &

# Wait for services to start
sleep 30

echo "Services started. Check logs: tail -f /var/log/carprice.log"
echo "Access: http://$(curl -s ifconfig.me):5000"
