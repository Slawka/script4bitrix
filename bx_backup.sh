#!/bin/bash

if [ "$1" == "" ]; then
    echo "Add key for backup
-d database
-f folder
-a All
"
    exit
fi

ach_folder=`date +"%Y%m%d"`_archive

mkdir /home/bitrix/backup/$ach_folder
cd /home/bitrix/backup/$ach_folder

if [ "$1" == "-d" ] || [ "$1" == "-a" ]; then


echo "############"
echo "Start BackUp DB: "`date`
echo "############"

for i in `mysql -e'show databases;'| grep -v information_schema | grep -v Database`; do mysqldump $i | /usr/bin/gzip -c > dump_`date +%Y-%m-%d`-$i.sql.gz; done

fi

if [ "$1" == "-f" ] || [ "$1" == "-a" ]; then

echo "############"
echo "Start BackUp File:"`date`
echo "############"

tar cfz `date +%Y-%m-%d-%H-%M`"_bitrix.tgz" /home/bitrix/www /home/bitrix/ext_www /home/bitrix/dehydrated  --warning=no-file-changed --exclude="/home/bitrix/www/bitrix/backup"

fi

echo "############"
echo "End BackUp:"`date`
echo "############"
