#!/bin/bash

#Get support packages
sudo apt-get update && sudo apt-get install -y curl wget software-properties-common

#get key for vbox
wget https://www.virtualbox.org/download/oracle_vbox_2016.asc

#add repo for vbox, add key and install
sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian xenial contrib' >> /etc/apt/sources.list"
sudo apt-key add ./oracle_vbox_2016.asc
sudo apt-get update
sudo apt-get install -y virtualbox-5.1

#instantiate vbox ifconfig settings
sudo ifconfig vboxnet0 up

#get minikube and kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && sudo chmod +x kubectl && sudo mv kubectl /usr/local/bin/

curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.20.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

#set up environment for minikube test
mkdir ./hellonode
cd hellonode
wget https://raw.githubusercontent.com/m-hemmings/MiscFiles/master/minikube/server.js
wget https://raw.githubusercontent.com/m-hemmings/MiscFiles/master/minikube/Dockerfile

#start minikube
minikube start

#Set docker context to minikube.  To teardown: eval $(minikube docker-env -u)
eval $(minikube docker-env)

#build docker container in minikube
docker build -t hello-node:v1 .

#create minikube deployment
kubectl run hello-node --image=hello-node:v1 --port:8080

#create a service
kubectl expose deployment hello-node --type=LoadBalancer

#To view contents, launch browser:
#minikube service hello-node

 
