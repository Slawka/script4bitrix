#!/bin/bash

# Before Run
# Add
# iptables -N bx_block;
# iptables -I INPUT -j bx_block


ip_block=`mysql -s -e "select distinct concat('iptables -I bx_block -p tcp -m tcp --dport 443 -s ',REMOTE_ADDR,' -j DROP;') ip from (select AUDIT_TYPE_ID ,REMOTE_ADDR,COUNT(*) as cn  from sitemanager.b_event_log
where TIMESTAMP_X >= now() - interval 7 day
and AUDIT_TYPE_ID in ('SECURITY_FILTER_PHP','SECURITY_FILTER_XSS','SECURITY_HOST_RESTRICTION','SECURITY_REDIRECT')
and REMOTE_ADDR IS NOT NULL
group by AUDIT_TYPE_ID ,REMOTE_ADDR 
HAVING cn>100
) as ipt;"`

iptables -F bx_block; 
eval $ip_block
