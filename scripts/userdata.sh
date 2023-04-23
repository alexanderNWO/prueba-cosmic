#!/bin/bash
snap install docker
addgroup --system docker
adduser ubuntu docker
newgrp docker
snap disable docker
snap enable docker
service docker start
docker run --name nginxd -d -p 80:80 nginx