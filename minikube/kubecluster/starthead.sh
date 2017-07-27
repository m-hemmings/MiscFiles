#!/bin/bash

#Ensure kubeadm is ready
sudo kubeadm reset
#Ensure kubelet is in a waiting state
sudo service kubelet restart
#init kubernetes
sudo kubeadm init

#Copy and take ownership of current config
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#create and apply flannel overlay network
kubectl create -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-rbac.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

