#su -
#!/bin/sh -e
# -e means exit if any command fails
SITE=demo2

BACKUPDIR=/var/www/backup
ROOT=/var/www/$SITE
DUMPDIR=local

DBHOST=127.0.0.1
DBPORT=3306
DBUSER=root
DBPASS=qaz1101
DBNAME=$SITE

TIMESTAMP=$(date +"%d.%m.%y.%H%M%S")
DUMPFILE=$DBNAME.sql
BACKUPFILE=$SITE'_'$TIMESTAMP'.tar.gz'
SITECORE=$SITE'_core.tar.gz'

#DIR=$(pwd)

#cd $ROOT/$DUMPDIR

if [ -f "$ROOT/$DUMPDIR/$DUMPFILE" ]; then
    rm $ROOT/$DUMPDIR/$DUMPFILE
fi
mysqldump -h$DBHOST -P$DBPORT -u$DBUSER -p$DBPASS --skip-dump-date --single-transaction $DBNAME > $ROOT/$DUMPDIR/$DUMPFILE
echo "db dump create"

#git add $NEW
#echo "$DBNAME.sql committed"

#fix access
#find . -type f|xargs chmod 777
#find . -type d|xargs chmod 777
#find . -type f|xargs chown www-data:www-data
#find . -type d|xargs chown www-data:www-data

#cd $BACKUPDIR

if [ ! -f "$BACKUPDIR/$SITECORE" ]; then
    tar -C"$ROOT/bitrix" --exclude='./cache' --exclude='./managed_cache' -cvzpf $BACKUPDIR/$SITECORE .
    echo "backup site core"
else
    echo "found site core: $BACKUPDIR/$SITECORE , skip core backup"
fi
echo "backup site pub"
tar -C"$ROOT" --exclude='./.git' --exclude='./bitrix' --exclude='./upload/tmp' -cvzpf $BACKUPDIR/$BACKUPFILE .

#cd $DIR

echo "backup complete!"