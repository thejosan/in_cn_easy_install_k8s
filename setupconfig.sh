#!/bin/bash
#初始化系统  必须使用root或者具备sudo权限帐号运行

#关闭防火墙
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo iptables -F && sudo iptables -X && sudo iptables -F -t nat && sudo iptables -X -t nat
sudo iptables -P FORWARD ACCEPT

#关闭swap
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

#关闭selinux
sudo setenforce 0
sudo sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
sudo sed -i "s/SELINUX=permissive/SELINUX=disabled/g" /etc/selinux/config

