#### Разметка
разбиваем так:
* 1G /boot ext2 - нельзя экономить, тут будет несколько ядер, полгига забивает
* 33Gb swap - для hibernate, лучше выделить
* other / btrfs - корень на btrfs, с возможностью быстрых снимков для бекапа
* выбираем шифрование для домашней папки - контролируем доступ самым простым способом
* ждем завершения
* перезагружаемся
  
#### Временно поднимаем сеть:
* ifconfig получаем интерфейс
* sudo dhclient интерфейс - поднимает сеть

`sudo dhclient enp4s0`

#### Звук
`pacmd list-sinks | grep -e 'name:' -e 'index'`

смотрим айдишник со звездочкой

Набираем pacmd, и табами подбираем команды как ниже

`set-default-source alsa_input.pci-0000_00_14.2.analog-stereo`

`set-default-sink alsa_output.pci-0000_00_14.2.analog-stereo`

`set-sink-mute alsa_output.pci-0000_00_14.2.analog-stereo false`

`set-sink-volume alsa_output.pci-0000_00_14.2.analog-stereo 0x10000`

добавляем их без pacmd в /etc/pulse/default.pa

`mcedit /etc/pulse/default.pa`

set-sink-port alsa_output.pci-0000_00_14.2.analog-stereo analog-output-headphones
set-sink-mute alsa_output.pci-0000_00_14.2.analog-stereo false
set-sink-volume alsa_output.pci-0000_00_14.2.analog-stereo 0x10000

#### Время
`sudo dpkg-reconfigure tzdata`

выбрать Europe/Moscow

#### mc
`sudo apt install mc`

* запускаем mc от пользователя
* настраиваем
* вводим select-editor
* обязательно жмем "сохранить настройки" - это создаст конфиг
* выходим из mc
* вводим select-editor

`sudo -i`

повторяем процедуру от рута

#### Настраиваем пакетный менеджер
* Выбираем ближайшие зеркала - яндекс и корбина
* Включаем установку из исходников, если нет пакета
* Настраиваем периодичность проверки - неделя

#### google chrome

`wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -`

`sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'`

`sudo apt update`

`sudo apt install google-chrome-stable`
 
Нужен стабильный - тот самый, что почти у всех клиентов

входим в учетку, настраиваем синхронизацию, ждем пока подтянет настройки

#### oracle jre
`sudo add-apt-repository ppa:webupd8team/java`

`sudo apt install oracle-java8-installer`

`sudo apt-get install oracle-java8-set-default`

`sudo update-java-alternatives -s java-8-oracle`

`java -version`

#### jetbrains toolbox
jetbrains toolbox устанавливает и обновляет phpstorm

Устанавливаем по информации из этих ссылок
[1](https://www.jetbrains.com/toolbox/download/download-thanks.html?platform=linux)
[2](https://github.com/nagygergo/jetbrains-toolbox-install/blob/master/jetbrains-toolbox.sh)
[3](https://askubuntu.com/questions/999762/installing-jetbrains-toolbox-on-ubuntu-17-10)


#### phpstorm
* в jetbrain toolbox жмем install phpshtorm, и ждем
* активируем
* настраиваем

`sudo mcedit /etc/sysctl.conf`

fs.inotify.max_user_watches = 524288

`sudo sysctl -p --system`

#### skype & telegramm
`sudo apt install skypeforlinux`

`sudo apt install `

#### автозапуск
добавляем в автозапуск skype,telegramm

#### первый бэкап
`sudo mkdir /root/backup`

`sudo btrfs subvolume snapshot -r / /root/backup/дата-время`

`sudo btrfs subvolume show /`

#### обновляемся
Запускаем полное обновление системы

#### yakuake
`sudo apt install yakuake`

#### чиним сеть
[doc](https://wiki.debian.org/ru/DHCP_Client)

`sudo mcedit /etc/network/interfaces`

Находим и комментируем

`#iface enp4s0 inet manual`

Добавляем

`iface enp4s0 inet dhcp`










sudo apt install mysql-server
sudo apt install mysql-workbench
http://help.ubuntu.ru/wiki/mysql
кодировки
в конец файла /etc/mysql/my.cnf
[server]
skip-character-set-client-handshake
character-set-server = utf8
init-connect='SET NAMES utf8'
collation-server=utf8_general_ci

[client]
default-character-set=utf8

[mysqldump]
default-character-set=utf8


sudo service mysql restart

https://www.digitalocean.com/community/tutorials/linux-apache-mysql-php-lamp-ubuntu-16-04-ru
sudo apt install apache2

sudo touch /etc/apache2/conf-available/bitrix.conf
sudo a2enconf bitrix
sudo mcedit /etc/apache2/conf-available/bitrix.conf
Добавить
ServerName local.host

/etc/hosts
127.0.0.1   local.host

Проверить конфиг
sudo apache2ctl configtest

Применить
sudo service apache2 reload

Набрать в браузере
local.host
Если все верно - откроется дефолтная страничка апача


/etc/apache2/mods-enabled/dir.conf
Поставить php первым
sudo service apache2 restart


sudo add-apt-repository ppa:ondrej/php
sudo apt install php7.1
/etc/php/7.1/apache2/php.ini
short_open_tag = On

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/bitr.ix.conf

/etc/hosts
127.0.0.1   bitr.ix

#### Настройка апача
sudo apt install libapache2-mpm-itk
sudo a2enmod mpm-itk

/etc/apache2/conf-available/tomas.conf
ServerName local.host
<Directory /home/tomas/PhpstormProjects>
    <IfModule mpm_itk_module>
        AssignUserId tomas tomas
    </IfModule>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

/etc/apache2/sites-available/bitr.ix.conf
<VirtualHost *:80>
        ServerName bitr.ix
        DocumentRoot /home/tomas/PhpstormProjects/bitr.ix
</VirtualHost>




План:
swapspace
zswap
readahead
preload
