更新日志 2020-4-1 更新版1.16.7版本 由于本人github网络老是出问题,commit老失败 现已经将项目移植码云。
==================================================
git clone -b 1.16.7 https://gitee.com/thejosan/in_cn_easy_install_k8s.git   
而且镜像也移到阿里云的镜像仓库

更新日志 2018-11-24  重新编译kubeadm 将所有证书有效期提升到10年，解决官方kubeadm证书1年后失效问题
==================================================
半年前，我学k8s , 差点从安装到放弃，用的是二进制文件安装，足足装了一个星期，最主要是网上的教程很多误人子弟，排很多坑！所以国庆我找时间写了个脚本安装

系统要求： yum源无问题的centos 7.X  redhat 7.x
注意事项： master node 的节点hostname 不能重名，否则会有问题。 

目前很多朋友帮测试过 centos 7.3 7.4 7.5 都可以一次安装成功

在matser节点 git clone  https://github.com/thejosan/in_cn_easy_install_k8s.git 

cd in_cn_easy_install_k8s/

sh install-master.sh 

如果服务器是多网卡 后面接参数填ip地址 sh install-master.sh 192.168.1.2

插件: dashboard flannel nginx-ingress(ds默认装在default) 如果有需要修改命名空间请修改 install-addons.sh 里面的参数

安装成功会生成 dashboard 的 token ，查看请自行cat token.txt 

dashboard 浏览方法: 用firefox 浏览 https://master-ip:30001 ,跳出不安全提示，然后高级点添加网站到安全例外

安装成功后会在/root目录生成 node节点的安装包，scp到node节点解压运行 ./install-node.sh 即可加入集群

未来还会更新推出双master ha版本。不过当务之急还是把promethous elk helm 插件的部署写到脚本里面，这些东西对学习k8s临床意义非常大。请关注我的更新！


更新日志 :------------------------------------------------------------

2018-11-24  重新编译kubeadm 将所有证书有效期提升到10年，解决证书只有一年有效期失效问题

2018-11-15  增加插件 heapster grafana influxdb 
