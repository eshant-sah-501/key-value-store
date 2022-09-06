#! /bin/bash
sudo yum update -y
sudo yum install -y docker git
sudo service docker start
sudo usermod -a -G docker ec2-user
git clone https://github.com/eshant-sah-501/key-value-store.git
cd /key-value-store
docker build -t key-server-flask:v1 .
sudo docker run --name key-server -p 5000:5000 -d key-server-flask:v1