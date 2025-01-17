#!/bin/bash

datafolder="{{ datafolder }}"
url="{{ cloud_url }}"
user="{{ cloud_user }}"
pass="{{ cloud_pass }}"
# disable return on empty for loop
shopt -s nullglob

/bin/systemd-notify --ready

while true; do
for f in $datafolder/*.pdf; do
	echo "Uploading -> $f"
	curl -u "$user:$pass" -H 'X-Requested-With: XMLHttpRequest' -k --fail -T $f $url/public.php/webdav/$f && rm $f
done

/bin/systemd-notify WATCHDOG=1
sleep 60

done