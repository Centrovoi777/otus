
<details> 
 <summary> авторизация по ssh </summary> 
для подключения создаем файл 

```
  $ nano ~/.ssh/autorized-keys
 ```
  добавляем ключ в 1 строчку без кавычек
```
"ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAqTqqZJDbs2iDZQPRXJ4jdVaeJX4nyX9Cmw8RMecY+z51VcZNyFuHUC9RHGaoS4WUz3iBCHRnootaFKhbiLNEWs0Nr+qQlN4waoSo1Y9sAtI+1DTIxGWePMglTuu4CjvHFKV1UStcU//iuvvSuYXMltopoEjUuz6qxfZHY4OztcZ5YnOU+q1NlCckEvfZmE/ZR6+MZ+DjtvoUtERNjyjnBF8kIK86UDBTSWIrVZ/b/8ZLL7gA9Px2Ri0X5NqtrZ/ZVBWuVgHJ0ktaG/opq7ywMNyWbvBLiYfS3po54jl9bxxAyDSMuN4dO1NI0BVCgTOnesth28RkXtSpq8WTwvgd6w=="  
```
даем права на файл 
```
chmod 700 /home/user_name/.ssh && chmod 600 /home/user_name/.ssh/authorized_keys
chown -R username:username /home/username/.ssh
```  
изменяем файл 
```
nano /etc/ssh/sshd_config
```
меняем PubkeyAutehentivation yes, раскоментируем AuthorazedKeysFile .ssh/authorized_keys отключаем аутентификацию по паролю PasswordAuthentication no <br>
перезапускаем службу
```
sudu systemctl restart ssh
```
</details>
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
$ sudo bash setupvpn.sh
```
После установки открываем ссылку в браузере "https://Ip-address/setup" <br>
Далее следуем инструкциям <br><br>
[Инструкция по добавлению пользователей и серверов](https://docs.pritunl.com/docs/connecting) <br>
</details>
переход по ssh по ключам
ssh -i ~/.ssh/appuser appuser@<ipaddress>
</details>
<details>
<summary> Урок №6 </summary>
 созданы скрипты bash, для установки mongodb, ruby, puma-server
 
 делаем файлы исполняемыми chmod +x /install_mongoDB.sh
 chown -R username:username /install_mongoDB.sh
 
создан бакет > инструкция по бакетам  https://gist.github.com/Nklya/b6d1a547415b123f6b0cd0e90d208bf8 

создание инстанса по скрипту
```sh
gcloud compute instances create reddit-app1 --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --scopes storage-ro --metadata startup-script-url=gs://tartup-script-url/startupscript.sh
```
 </details>
   <details>
 <summary> Урок №7 </summary>
 Установлен Packer https://www.packer.io/downloads.html
 
 и подключен к gcloud
 ```sh
 gcloud auth application-default login
 ```
 Создана ветка packer-base добавлен файл сборки ubuntu16.json
 
 Проведена проверка файла
 ```sh
 packer validate ./ubuntu16.json
  ```
 
Самостоятельное задание №1, №2 и №3

Добавление файла variables.json добавлен в исключения для git,

проверка для обоих файлов сразу 
 ```sh
 packer validate -var-file ./variables.json ./ubuntu16.json
  ```

сборка шаблона
  ```sh
packer build -var-file ./variables.json ./ubuntu16.json 
  ```
  Пример вынесения в файл variables.json:
  
В файле шаблона ubuntu16.json
 ```sh
  "variables":
  {
  "project_id": "null",
  },
	"builders": [
    {
	"project_id": "{{ user `project_id` }}"
	}
 ```
В файле variables.json 
  ```sh	
  {
  "project_id": "наш проект"
  }  
  ```
 Добавил опции размера диска "disk_size": "10" и теги для брандмауэра "tags": "puma-server"
 
 
 Задание №1 под *
 
создание инстанса  из изображения
 gcloud compute instances create test --image-family=reddit-base --image-project=api-project-739750082124
   </details>
   
   <details>
 <summary> Урок №8 </summary>
 установил версию выше чем 0.11.11, версию 0.12.28
 Пример коннектора к виртуальной машине (отличается от 0.11.11

```sh
   connection {
    type    = "ssh"
    user    = "centr"
    host    = "${google_compute_instance.app.network_interface[0].access_config[0].nat_ip}"
    agent   = false
    timeout = "2m"
    # путь до приватного ключа
    private_key = "${file(var.private_key_path)}"
```
основные команды

```sh
 terraform plan
 terraform apply
 
```
добавление двух ключей ssh
```sh
resource "google_compute_project_metadata" "ssh_keys" {
  metadata = {
    # путь до публичного ключа
    ssh-keys = "centr:${file(var.public_key_centr)}\n Centr:${file(var.public_key_Centr)}"
  }
}

```
 </details>
   <details>
    <summary> Урок №11 </summary>
	Собрали шаблон инстанса в packer
	
packer build -var-file packer-base/variables.json packer-base/ubuntu16.json

Создали инстансы в terraform

/terraform-2/stage$ terraform apply

в app.yml поменять db_host на новый IP server_db

в конце выполнить 

ansible-playbook site.yml -u centr

  </details>
