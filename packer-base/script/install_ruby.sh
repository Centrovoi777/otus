#!/bin/bash
# install ruby
echo 'update repository'
apt update
echo 'install ruby'
apt install -y ruby-full ruby-bundler build-essential
echo 'check installation'
ruby -v
bundler -v
