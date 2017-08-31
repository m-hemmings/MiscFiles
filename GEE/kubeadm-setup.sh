apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
curl https://raw.githubusercontent.com/m-hemmings/MiscFiles/master/GEE/kubernetes.list > /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y docker.io
apt-get install -y kubelet kubeadm kubectl kubernetes-cni
