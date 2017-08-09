#!/bin/bash

#install nginx and create script to set nginx config
sudo apt-get install nginx -y
curl https://raw.githubusercontent.com/m-hemmings/MiscFiles/master/minikube/nginx/makeConfig.sh > $(pwd)/makeConfig.sh

#start minikube
minikube start

#instantiate vbox ifconfig settings
sudo ifconfig vboxnet0 up
