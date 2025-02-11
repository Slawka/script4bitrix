#!/bin/bash

echo "############"
echo "Start BackUp DB: "`date`
echo "############"

ach_folder=`date +"%Y%m%d%H%M"`_archive

mkdir /home/bitrix/backup/$ach_folder
cd /home/bitrix/backup/$ach_folder

for i in `mysql -e'show databases;'| grep -v information_schema | grep -v Database`; do mysqldump $i | /usr/bin/gzip -c > dump_`date +%Y-%m-%d`-$i.sql.gz; done

echo "############"
echo "Start BackUp File:"`date`
echo "############"

tar cfz $ach_folder"_bitrix.tgz" /home/bitrix/www /home/bitrix/www_ext /home/bitrix/dehydrated  --warning=no-file-changed --exclude="/home/bitrix/www/bitrix/backup" 

echo "############"
echo "End BackUp:"`date`
echo "############"
