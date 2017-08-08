#!/bin/bash

#set up environment for minikube test
mkdir hellonode
curl https://raw.githubusercontent.com/m-hemmings/MiscFiles/master/minikube/server.js > $(pwd)/hellonode/server.js
curl https://raw.githubusercontent.com/m-hemmings/MiscFiles/master/minikube/Dockerfile > $(pwd)/hellonode/Dockerfile
curl https://raw.githubusercontent.com/m-hemmings/MiscFiles/master/minikube/nginx/makeConfig.sh > $(pwd)/hellonode/makeConfig.sh

#start minikube
minikube start

#instantiate vbox ifconfig settings
sudo ifconfig vboxnet0 up

#Set docker context to minikube.  To teardown: eval $(minikube docker-env -u)
#eval $(minikube docker-env)

#build docker container in minikube
#sudo docker build -f $(pwd)/hellonode/Dockerfile -t hello-node:v1 .

#create minikube deployment
#kubectl run hello-node --image=hello-node:v1 --port=8080

#create a service
#kubectl expose deployment hello-node --type=LoadBalancer

sudo apt-get install nginx -y
#sudo $(pwd)/hellonode/makeConfig.sh $(minikube service hello-node --url)
#sudo nginx -s reload

#printf "\nSetup complete:\n"
#printf "To view contents, launch browser:\n"
#printf "minikube service hello-node\n"
#printf "\n"
#printf "To update, change contents of server.js, rebuild docker container and assign new image to service (example):\n"
#printf "docker build -t hello-node:v2 ."
#printf "kubectl set image deployment/hello-node hello-node=hello-node:v2\n"
#printf "\n"
#printf "To tear down:\n"
#printf "eval \$(minikube docker-env -u)\n"
#printf "kubectl delete service hello-node\n"
#printf "kubectl delete deployment hello-node\n"
#printf "minikube stop"

 
