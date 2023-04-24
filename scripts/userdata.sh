#!/bin/bash
apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
cd ~
curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
bash nodesource_setup.sh
apt install nodejs -y
apt install npm -y
cd /home/ubuntu/
git clone https://github.com/drashland/deno-drash-realworld-example-app.git
cd deno-drash-realworld-example-app/
service docker start
docker run --name some-nginx -d -p 80:80 nginx