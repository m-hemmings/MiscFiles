#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

apt-get update && apt-get install -y apt-transport-https -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat << EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update 
apt-get install docker.io kubelet kubeadm kubectl kubernetes-cni -y
#SECRET=$(curl -k https://head.sundewproject.org:8181/get_secret)
SECRET=$(curl http://sundew-project.cs.uvic.ca:8080/get_secret)
swapoff -a
kubeadm join 142.104.71.105:6443 --token $SECRET --discovery-token-ca-cert-hash sha256:0ce61e6e8443ae255c9f7cfe266570ee64d2b38a6ebbc7a452f0d83e240ac9b1
