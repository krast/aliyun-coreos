
scp -r * root@139.196.174.117:/home/coreos_updates/amd64-usr/
scp nginx.tar.gz root@139.196.174.117:/home/

docker run --name nginx -p 80:80 -v /home/coreos_updates/amd64-usr:/home/coreos_updates/amd64-usr:ro -v /home/default.conf:/etc/nginx/conf.d/default.conf:ro -d nginx


scp -r /root/.ssh root@139.196.174.117:/root

docker load -i nginx



scp -r * root@139.196.148.101:/home/coreos_updates/amd64-usr/
