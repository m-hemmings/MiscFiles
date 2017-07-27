#!/bin/bash

sudo kubeadm reset
sudo service kubelet restart
echo "Ready to run kubeadm join command"
