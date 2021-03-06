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

#get minikube and kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && sudo chmod +x kubectl && sudo mv kubectl /usr/local/bin/

curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.20.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

#set up environment for minikube test
mkdir hellonode
curl https://raw.githubusercontent.com/m-hemmings/MiscFiles/master/minikube/server.js > $(pwd)/hellonode/server.js
curl https://raw.githubusercontent.com/m-hemmings/MiscFiles/master/minikube/Dockerfile > $(pwd)/hellonode/Dockerfile

#start minikube
minikube start

#instantiate vbox ifconfig settings
sudo ifconfig vboxnet0 up

#Set docker context to minikube.  To teardown: eval $(minikube docker-env -u)
eval $(minikube docker-env)

#build docker container in minikube
sudo docker build -f $(pwd)/hellonode/Dockerfile -t hello-node:v1 .

#create minikube deployment
kubectl run hello-node --image=hello-node:v1 --port=8080

#create a service
kubectl expose deployment hello-node --type=LoadBalancer


printf "\nSetup complete:\n"
printf "To view contents, launch browser:\n"
printf "minikube service hello-node\n"
printf "\n"
printf "To update, change contents of server.js, rebuild docker container and assign new image to service (example):\n"
printf "docker build -t hello-node:v2 ."
printf "kubectl set image deployment/hello-node hello-node=hello-node:v2\n"
printf "\n"
printf "To tear down:\n"
printf "eval \$(minikube docker-env -u)\n"
printf "kubectl delete service hello-node\n"
printf "kubectl delete deployment hello-node\n"
printf "minikube stop"

 
