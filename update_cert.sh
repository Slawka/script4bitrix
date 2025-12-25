#!/bin/bash
hfile=`grep ".htsecure" /etc/nginx/bx/**/*.conf | grep "_enabled" | sed -e "s/.*\(\/home.*htsecure\).*/\1/"`

rand=$RANDOM

echo "Rename File Block redirect"

for f in $hfile; do
  echo "mv $f $f-OFF-$rand"
  mv $f $f-OFF-$rand
done

echo "Start bx-dehydrated"
/opt/webdir/bin/bx-dehydrated

echo "Rename File UnBlock redirect"

for f in $hfile; do
  echo "mv $f-OFF-$rand $f"
  mv $f-OFF-$rand $f
done

systemctl reload nginx

echo "----------- OUT -----------"
echo $hfile
