#!/bin/sh
docker run -itd -p 53:53/udp -p 6379:6379 -e NS="domain.com" -e IP="213.23.2.122" mosquitood/dnsleakserver
