Create backub DB or Full
Block ip

Crontab delete old file
```
10 13 * * * root ls -t -d /home/bitrix/backup/*_archive | tail -n +8 | xargs rm -rf
20 13 * * * root ls -t /home/bitrix/backup/archive/www_backup_sitemanager_* | tail -n +5 | xargs rm -rf
```
