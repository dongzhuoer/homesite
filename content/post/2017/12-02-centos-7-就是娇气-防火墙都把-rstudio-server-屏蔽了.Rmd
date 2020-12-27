---
title: CentOS 7 就是娇气，防火墙都把 RStudio Server 屏蔽了
author: Zhuoer Dong
date: '2017-12-02'
slug: centos-7-就是娇气-防火墙都把-rstudio-server-屏蔽了
categories: 2017
tags: []
authors: []
---

RStudio Server 确实好用，就给谢老师的 CentOS 工作站也装了一个 ^[从 https://www.rstudio.com/products/rstudio/download-server/ 获取最新版下载地址]：

```bash
sudo yum install -y R

aria2c https://download2.rstudio.org/rstudio-server-rhel-1.1.442-x86_64.rpm
sudo yum install -y --nogpgcheck rstudio-server-rhel-1.1.442-x86_64.rpm
```

然而 CentOS 装软件果然没 Ubuntu 那么爽，无法实现远程访问。看起来是防火墙的原因。

感谢这篇  [post](https://www.vultr.com/docs/how-to-install-rstudio-server-on-centos-7)：

```bash
sudo firewall-cmd --permanent --zone=public --add-port=8787/tcp
sudo firewall-cmd --reload
```

