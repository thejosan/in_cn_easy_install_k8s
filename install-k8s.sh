#!/bin/bash
#yum 安装 k8s组件 ，阿里云的源
#VERSION="1.11.3"
VERSION=$1
sudo cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
        http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

#sudo yum install -y kubelet-$VERSION kubeadm-$VERSION kubectl-$VERSION --disableexcludes=kubernetes 
sudo yum install -y kubelet-$VERSION kubectl-$VERSION --disableexcludes=kubernetes
tar -zxf kubeadm.tar.gz
rm -rf kubeadm.tar.gz
sudo systemctl enable kubelet

sudo cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

DOCKER_CGROUPS=$(docker info | grep 'Cgroup' | cut -d' ' -f3)
echo $DOCKER_CGROUPS
sudo cat > /etc/default/kubelet <<EOF
KUBELET_KUBEADM_EXTRA_ARGS=--cgroup-driver=$DOCKER_CGROUPS
EOF

sudo sysctl --system
sudo systemctl daemon-reload
sudo systemctl start kubelet

