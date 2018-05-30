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

#### Время
`sudo dpkg-reconfigure tzdata`

выбрать Europe/Moscow

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

`sudo update-java-alternatives -s java-8-oracle`

`java -version`

#### jetbrains toolbox
jetbrains toolbox устанавливает и обновляет phpstorm

Устанавливаем по информации из этих ссылок
* https://www.jetbrains.com/toolbox/download/download-thanks.html?platform=linux
* https://github.com/nagygergo/jetbrains-toolbox-install/blob/master/jetbrains-toolbox.sh
* https://askubuntu.com/questions/999762/installing-jetbrains-toolbox-on-ubuntu-17-10


#### phpstorm
* в jetbrain toolbox жмем install phpshtorm, и ждем
* активируем
* настраиваем

#### первый бэкап
`sudo mkdir /root/backup`

`sudo btrfs subvolume snapshot -r / /root/backup/дата-время`

`sudo btrfs subvolume show /`


#### обновляемся
Запускаем полное обновление системы

