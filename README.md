<details>
  <summary> Урок №5 </summary>
    <details> <summary> setupvpn.sh установка OVPN сервера prinunl </summary>
     
на хосте выполняем комманды

```sh
cat <<EOF> setupvpn.sh <br>
#!/bin/bash <br>
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list <br>
echo "deb http://repo.pritunl.com/stable/apt xenial main" > /etc/apt/sources.list.d/pritunl.list <br>
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 0C49F3730359A14518585931BC711F9BA15703C6 <br>
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A <br>
apt-get --assume-yes update <br>
apt-get --assume-yes upgrade <br>
apt-get --assume-yes install pritunl mongodb-org <br>
systemctl start pritunl mongod <br>
systemctl enable pritunl mongod <br>
EOF <br>
```  
```sh
$ sudo bash setupvpn.sh <br>
```
После установки открываем ссылку в браузере "https://Ip-address/setup" <br>
Далее следуем инструкциям <br><br>
Инструкция по добавлению пользователей и серверов https://docs.pritunl.com/docs/connecting <br>
</details>
</details>
