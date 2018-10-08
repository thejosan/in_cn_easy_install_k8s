半年前，我学k8s , 差点从安装到放弃，用的是二进制文件安装，足足装了一个星期，最主要是网上的教程很多误人子弟，排很多坑！所以国庆我找时间写了个脚本安装

系统需求: yum源无问题的centos 7.X  redhat 7.x

目前很多朋友帮测试过 centos 7.3 7.4 7.5 都可以一次安装成功

在matser节点 git clone  https://github.com/thejosan/in_cn_easy_install_k8sv1.11.3.git 

cd in_cn_easy_install_k8sv1.11.3/

./install-master.sh 

如果服务器是多网卡 后面接参数填ip地址 ./install-master.sh 192.168.1.2

插件: dashboard flannel nginx-ingress(ds默认装在default) 如果有需要修改命名空间请修改 install-addons.sh 里面的参数

安装成功会生成 dashboard 的 token ，查看请自行cat token.txt 

dashboard 浏览方法: 用firefox 浏览 https://master-ip:30001 ,跳出不安全提示，然后高级点添加网站到安全例外

安装成功后会在/root目录生成 node节点的安装包，scp到node节点解压运行 ./install-node.sh 即可加入集群

未来还会更新推出双master ha版本。不过当务之急还是把promethous elk helm 插件的部署写到脚本里面，这些东西对学习k8s临床意义非常大。请关注我的更新！
