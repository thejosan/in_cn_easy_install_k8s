#!/bin/bash
NameSpace="default"

echo -e "\033[32m## 安装网络组件flannel. =====================================================================\033[0m"
sudo kubectl apply -f addons/flannel/kube-flannel.yml

echo -e "\033[32m## 安装反响代理组件nginx-ingress. ===========================================================\033[0m"
echo -e "\033[32m## 默认 ingress 安装在default. 自定义命名空间请修改 install-addons.sh脚本中的相关参数 \033[0m"
sudo cp addons/ingress/ingress-Template.yaml addons/ingress/ingress.yaml
sudo sed -i "s/\[namespace\]/$NameSpace/g" addons/ingress/ingress.yaml
sudo kubectl apply -f addons/ingress/ingress.yaml

echo -e "\033[32m## 安装metrics-server HPA对象要到这个 . ======================================================\033[0m"
sudo kubectl apply -f addons/metrics-server/


echo -e "\033[32m## k8s-web组件Dashboard =====================================================================\033[0m"
sudo kubectl apply -f addons/dashboard/1.10.0/kubernetes-dashboard.yaml
sudo kubectl create sa dashboard-admin -n kube-system
sudo kubectl create clusterrolebinding dashboard-admin --clusterrole=cluster-admin --serviceaccount=kube-system:dashboard-admin
ADMIN_SECRET=$(sudo kubectl get secrets -n kube-system | grep dashboard-admin | awk '{print $1}')
DASHBOARD_LOGIN_TOKEN=$(sudo kubectl describe secret -n kube-system ${ADMIN_SECRET} | grep -E '^token' | awk '{print $2}')
echo ${DASHBOARD_LOGIN_TOKEN} > token.txt
echo -e "\033[32m 浏览方式: 用firefox 浏览 https://nodes-ip:30001 (要用命令查看pod-dashboard所对应的node节点),跳出不安全提示，然后高级点添加网站到安全例外\033[0m"
echo -e "\033[33m 登录token见 安装目录下token.txt \033[0m"

