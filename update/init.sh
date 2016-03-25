#!/bin/bash

mkdir -p /home/coreos_updates/amd64-usr

chmod 777 /etc/systemd/network/*


vi /etc/coreos/update.conf
SERVER=http://139.196.174.117/991.0.0/
GROUP=stable
