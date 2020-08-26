#!/bin/bash
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
sudo apt-get install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
echo 'Проверяем работу mongodb'
sudo systemctl status mongod
# install ruby
echo 'update repository'
sudo apt update
echo 'install ruby'
sudo apt install -y ruby-full ruby-bundler build-essential
echo 'check installation'
ruby -v
bundler -v
cd ~/
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
echo 'смотрим какой порт слушает puma'
ps aux | grep puma
