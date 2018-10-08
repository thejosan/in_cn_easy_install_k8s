#!/bin/bash
# 没科学上网只能老实做引用，各位放心使用，build引自官方镜像
# 具体见 https://hub.docker.com/u/thejosan20/  https://github.com/thejosan?tab=repositories

sudo docker pull thejosan20/kube-apiserver-amd64:v1.11.3
sudo docker tag  thejosan20/kube-apiserver-amd64:v1.11.3 k8s.gcr.io/kube-apiserver-amd64:v1.11.3

sudo docker pull thejosan20/kube-controller-manager-amd64:v1.11.3
sudo docker tag  thejosan20/kube-controller-manager-amd64:v1.11.3 k8s.gcr.io/kube-controller-manager-amd64:v1.11.3

sudo docker pull thejosan20/kube-scheduler-amd64:v1.11.3
sudo docker tag  thejosan20/kube-scheduler-amd64:v1.11.3 k8s.gcr.io/kube-scheduler-amd64:v1.11.3

sudo docker pull thejosan20/kube-proxy-amd64:v1.11.3
sudo docker tag  thejosan20/kube-proxy-amd64:v1.11.3 k8s.gcr.io/kube-proxy-amd64:v1.11.3

sudo docker pull thejosan20/pause:3.1
sudo docker tag  thejosan20/pause:3.1 k8s.gcr.io/pause:3.1

sudo docker pull thejosan20/etcd-amd64:3.2.18
sudo docker tag  thejosan20/etcd-amd64:3.2.18 k8s.gcr.io/etcd-amd64:3.2.18

sudo docker pull thejosan20/coredns:1.1.3
sudo docker tag  thejosan20/coredns:1.1.3 k8s.gcr.io/coredns:1.1.3

sudo docker pull thejosan20/kubernetes-dashboard-amd64:v1.10.0
sudo docker tag  thejosan20/kubernetes-dashboard-amd64:v1.10.0  k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.0

sudo docker pull thejosan20/flannel:v0.10.0-amd64
sudo docker tag  thejosan20/flannel:v0.10.0-amd64 quay.io/coreos/flannel:v0.10.0-amd64

sudo docker images | grep k8s.gcr.io

