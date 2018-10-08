#!/bin/bash
# 安装master
# cd 到目录中运行 ./install-master.sh 就可以
# 多网卡请输入网卡IP  例如 ./install-master.sh 192.168.1.1 
K8sVersion="1.11.3"

echo -e "\033[32m## 初始化k8s所需要环境. =====================================================================\033[0m"
/bin/bash setupconfig.sh

echo -e "\033[32m## 安装docker,如果不需要请注释该行,安装新版docker修改下面这句 /bin/bash install-docker.sh ===\033[0m"
/bin/bash install-docker.sh new
#/bin/bash install-docker.sh

echo -e "\033[32m## 下载kubeadm所需要的镜像. =================================================================\033[0m"
echo -e "\033[32m## 针对国内网络，没科学上网只能老实做镜像引用，各位放心使用，build引自官方镜像 \033[0m"
echo -e "\033[32m## 查Dockerfile网址 https://hub.docker.com/u/thejosan20/  https://github.com/thejosan?tab=repositories \033[0m"
/bin/bash pull-docker.sh

echo -e "\033[32m## yum安装k8s ===============================================================================\033[0m"
/bin/bash install-k8s.sh $K8sVersion

echo -e "\033[32m## 安装并初始化master =======================================================================\033[0m"
if [ ! -n "$1" ] ;then
	echo "kubeadm init --kubernetes-version=v$K8sVersion --pod-network-cidr=10.244.0.0/16"
	echo "Please wait a few minutes!"
	sudo kubeadm init --kubernetes-version=v$K8sVersion --pod-network-cidr=10.244.0.0/16 > init.log
else
        echo "kubeadm init --kubernetes-version=v$K8sVersion --apiserver-advertise-address $1 --pod-network-cidr=10.244.0.0/16" 
        echo "Please wait a few minutes!"
	sudo kubeadm init --kubernetes-version=v$K8sVersion --apiserver-advertise-address $1 --pod-network-cidr=10.244.0.0/16 > init.log
fi

JoinCommand=`grep "kubeadm join" init.log`
if [ $? -eq 0 ]; then
    echo -e "\033[32m## k8s-master安装成功，节点加入集群命令如下: =============================================\033[0m"
    echo "$JoinCommand"
    sudo cp node-template.sh install-node.sh
    sudo chmod +x install-node.sh
    echo "$JoinCommand" >> install-node.sh
    sudo mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

    echo -e "\033[32m## k8s安装插件: ==========================================================================\033[0m"
    /bin/bash install-addons.sh

    echo -e "\033[32m## 生成node节点安装包 =====================================================================\033[0m"
    mkdir -p /tmp/k8s-node-install
    cp setupconfig.sh install-docker.sh pull-docker.sh install-k8s.sh install-node.sh /tmp/k8s-node-install
    cd /tmp
    tar -czf k8s-node-install.tar.gz k8s-node-install
    sudo mv k8s-node-install.tar.gz /root/
    rm -rf /tmp/k8s-node-install
    echo -e "\033[32m## 安装包路径在 /root/k8s-node-install.tar.gz scp到你node节点解压后运行./install-node.sh 即可.\033[0m"
else
    echo -e "\033[31m kubeadm init failed! 初始化失败!请查看安装日志 cat init.log \033[0m"
fi

