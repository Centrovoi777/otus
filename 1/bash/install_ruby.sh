#!/bin/bash
# install ruby
echo 'update repository'
sudo apt update
echo 'install ruby'
sudo apt install -y ruby-full ruby-bundler build-essential
echo 'check installation'
ruby -v
bundler -v
