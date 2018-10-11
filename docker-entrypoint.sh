#!/bin/sh
set -e
redis-server /etc/redis.conf
pm2 start /data/src/dns.js
pm2 logs dns
