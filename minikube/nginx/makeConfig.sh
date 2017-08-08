#!/bin/bash
#
# URL can be found by running minikube service <service-name> --url and passing the result as an argument to this script
#

if [ $# -eq 0 ]
  then printf "No arguments supplied, please provide minikube address"
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

url=$(awk -F/ '{print $NF}' | cut -d ":" -f1)
port=$(awk -F/ '{print $NF}' | cut -d ":" -f2)

echo "# nginx base config file to redirect to minikube location
# To be placed in /etc/nginx/sites-enabled/

server {
  listen 80;
  location /minikube/ {
    proxy_pass http://$url:$port
    $1;
    proxy_http_version 1.1;
      proxy_set_header Upgrade \$http_upgrade;
      proxy_set_header Connection "upgrade";      
      proxy_pass_request_headers on;
  }
  location / {
    proxy_pass http://$url:30000;
  }
}" > /etc/nginx/sites-enabled/minikube.conf


