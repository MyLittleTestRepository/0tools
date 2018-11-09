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

#### locale
sudo locale-gen ru_RU.UTF-8
sudo update-locale LANG=ru_RU.UTF-8
Перелогинься

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

лучше такой [вариант](https://askubuntu.com/questions/1084415/ubuntu-18-04-ethernet-not-configuring-automatically/1084423)
комментируем все #iface enp4s0 *, и network manager сам все поднимает

 ---








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
sudo apt install php7.1 php7.1-xdebug php7.1-pdo-mysql
/etc/php/7.1/apache2/php.ini

    short_open_tag = On
    error_reporting = E_ALL
    display_errors = On
    display_startup_errors = On
    track_errors = On
    error_prepend_string = "<pre><span style='color: #ff0000'>"
    error_append_string = "</span></pre>"


/etc/php/7.1/mods-available/xdebug.ini

    xdebug.remote_enable = 1
    xdebug.remote_connect_back = 1
    xdebug.remote_port = 9000
    xdebug.max_nesting_level = 512
    xdebug.file_link_format = phpstorm://open?%f:%l


sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/bitr.ix.conf

/etc/hosts

    127.0.0.1   bitr.ix

#### Настройка апача
sudo apt install libapache2-mpm-itk
sudo a2enmod mpm_itk

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

sudo a2enmod rewrite
sudo service apache2 restart

sudo apt install php7.2-pdo-mysql
sudo service apache2 restart

План:
swapspace
zswap
readahead
preload

sudo btrfs subvolume snapshot -r / /root/backup/`date +%d%m%y%H%M%S`

Боевой:
пользователь www с доступом на чтение к сайту - веб-сервер, в основном читает, пишет только в несколько директорий
пользователь git с доступом на запись контентной части сайта - для безопасного внедрения правок, может читать весь сайт, но не может перезаписывать настройки
пользователь web-admin с полным доступом к сайту - для настройки и поддержки сайта

---

#### Переносим индексы шторма в рамдиск

получаем uid:gid

`getent passwd $USER`

    tomas:x:1000:1000:tomas,,,:/home/tomas:/bin/bash

создаем и настраиваем точку монтирования

`sudo mkdir -p /var/ramdisks/phpstorm/index`

`sudo chown -R tomas:tomas /var/ramdisks/phpstrom`

прописываем её

/etc/fstab:

    tmpfs /var/ramdisks/phpstorm/index tmpfs defaults,rw,size=4G,noexec,nodev,nosuid,noatime,uid=1000,gid=1000,mode=0700 0 0

перезагружаемся, чтобы диск самостоятельно смонтировался

`shutdown -r now`

заменяем индекс ссылкой

`rm -r /home/tomas/.PhpStorm2018.2/system/index`

`ln -s /var/ramdisks/phpstorm/index /home/tomas/.PhpStorm2018.2/system/index`

пересоздаем индекс, запустив шторм

#### Сохраняем состояние рамдиска с индексом шторма

создаем зеркало рамдиска

`mkdir -p .ramdisks/index`

создаем сервис синхронизации

`mkdir -p .local/share/systemd/user`

`touch .local/share/systemd/user/phpstorm_index_ramdisk.service`

`mcedit .local/share/systemd/user/phpstorm_index_ramdisk.service`

.local/share/systemd/user/phpstorm_index_ramdisk.service:

    [Service]
    Type=oneshot
    RemainAfterExit=true
    StandardOutput=journal
    ExecStart=/usr/bin/rsync --quiet --recursive --times /home/tomas/.ramdisks/index/ /var/ramdisks/phpstorm/index/
    ExecStop=/usr/bin/rsync --quiet --recursive --times /var/ramdisks/phpstorm/index/ /home/tomas/.ramdisks/index/
    [Install]
    WantedBy=default.target

включаем сервис

`systemctl --user enable phpstorm_index_ramdisk.service`

запускаем

`systemctl --user start phpstorm_index_ramdisk.service`

смотрим ошибки

`systemctl --user status phpstorm_index_ramdisk.service`

перед logout сервис автоматически сохранит индекс из рамдиска на диск

после login сервис автоматически подгрузит индекс на рамдиск

---









