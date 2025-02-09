#!/bin/bash

sites=$(/usr/bin/ls -I README /etc/letsencrypt/live/)

json="["

for site in $sites; do
  json+="{\"{#SITE}\":\"$site\"},"
done

json="${json%,}"
json+="]"
echo "$json"
