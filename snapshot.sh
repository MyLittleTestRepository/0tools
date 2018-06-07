btrfs subvolume snapshot -r / /root/backup/`date +%d%m%y%H%M%S`
btrfs subvolume delete /root/backup/@bak_0506180846
