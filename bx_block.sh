#!/bin/bash

ip_block=`mysql -s -e "
select REMOTE_ADDR ip from (select REMOTE_ADDR,COUNT(*) as cn  from sitemanager.b_event_log
where TIMESTAMP_X >= now() - interval 7 day
and AUDIT_TYPE_ID in ('SECURITY_FILTER_PHP','SECURITY_FILTER_XSS','SECURITY_HOST_RESTRICTION','SECURITY_REDIRECT')
and REMOTE_ADDR IS NOT NULL
group by REMOTE_ADDR
HAVING cn>5) as ipt ;
" | tr -s "\n" " "`

echo "List Block IP"
echo "-------------------------------------------------------------------------------------------------"
echo $ip_block
echo "-------------------------------------------------------------------------------------------------"

fail2ban-client -vvv  set nginx-bad-request banip $ip_block ;
fail2ban-client -vvv  set sshd banip $ip_block ;
