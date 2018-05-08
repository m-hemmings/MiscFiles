#!/bin/bash
USERID=id -u
if [ "$USERID" -ne 0 ]
  then  echo "Script requires to be run as root"
  exit
fi

apt-get update && apt-get install -y apt-transport-https -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat << EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update 
apt-get install docker.io kubelet kubeadm kubectl kubernetes-cni -y
SECRET = curl('https://head.sundewproject.org:8181/get_secret')
kubeadm join 142.104.71.105:6443 --token $SECRET --discovery-token-ca-cert-hash sha256:4d4d2122e5fff8cb29fc6c628b4ac0a4ceeea6fbb8243b95d1d37a1a05190730
