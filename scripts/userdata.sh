#!/bin/bash
apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
groupadd docker
usermod -aG docker ubuntu
newgrp docker
cd ~
curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
bash nodesource_setup.sh
apt install nodejs -y
apt install npm -y
cd /home/ubuntu/
service docker start
git clone https://github.com/jjchiw/deno-drash-realworld-example-app.git
cd deno-drash-realworld-example-app/
rm src/.env
printf "DB_USER=${db_user}
DB_PASSWORD=${db_password}
DB_DATABASE=${db_database}
DB_HOSTNAME=${db_hostname}
DB_PORT=${db_port}
DB_ENABLE_TLS=false
VUE_APP_API_URL=${vue_app_url}:1667
" > /home/ubuntu/deno-drash-realworld-example-app/src/.env
docker compose build && docker compose up -d
docker compose exec drash bash
/root/.deno/bin/nessie migrate
/root/.deno/bin/nessie seed
