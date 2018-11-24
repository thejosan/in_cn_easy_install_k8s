#!/bin/bash
# cd 到目录中运行 ./install-node.sh 就可以了
K8sVersion="1.11.3"
echo -e "\033[32m## 初始化k8s所需要环境. =====================================================================\033[0m"
/bin/bash setupconfig.sh
echo -e "\033[32m## 安装docker,如果不需要请注释该行,安装新版docker修改下面这句 /bin/bash install-docker.sh ===\033[0m"
/bin/bash install-docker.sh
echo -e "\033[32m## 下载kubeadm所需要的镜像. =================================================================\033[0m"
echo -e "\033[32m## 针对国内网络，没科学上网只能老实做镜像引用，各位放心使用，build引自官方镜像 \033[0m"
echo -e "\033[32m## 查Dockerfile网址 https://hub.docker.com/u/thejosan20/  https://github.com/thejosan?tab=repositories \033[0m"
/bin/bash pull-docker.sh
echo -e "\033[32m## yum安装k8s ===============================================================================\033[0m"
/bin/bash install-k8s.sh $K8sVersion
\cp -rf kubeadm /usr/bin/kubeadm
rm -rf kubeadm
echo -e "\033[32m## node加入k8s集群 ===============================================================================\033[0m"

