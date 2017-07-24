#!/bin/bash

sudo apt-get update && sudo apt-get install -y curl wget software-properties-common
wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian xenial contrib' >> /etc/apt/sources.list"
sudo apt-key add ./oracle_vbox_2016.asc
sudo apt-get update
sudo apt-get install -y virtualbox-5.1

sudo ifconfig vboxnet0 up

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && sudo chmod +x kubectl && sudo mv kubectl /usr/local/bin/

curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.20.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

mkdir ./hellonode
cd hellonode
wget 
