---
title: Ubuntu 的 Docker 终于跟上官方的脚步了
author: Zhuoer Dong
date: '2019-03-27'
slug: ubuntu-docker-keepup
categories: 2019
tags: []
authors: []
---

第一次装 Docker 真是噩梦，后来我就一直都去清华镜像站下载 `.deb`。直到今天我整理 VPS 的安装脚本时，觉得用 `.deb` 装 Docker 不够自动化，因为还得手动维护最新版的 URL，就想看看 Ubuntu 软件仓库的 Docker 更新到哪一版本了。不看不知道，一看吓一跳，虽然找软件名花了点时间（改成 `docker.io` 了），但居然更新到了 `18.09.2`，镜像站也才 `18.09.3` 啊。看来又有一个软件可以方便地维护了。

------------------------------------------

附我以前写的安装说明：

DONOT follow the official guide ^[the network is awfully terrible], rather, directly download `.deb` ^[recently Docker has been splitted into three `.deb`, you needn't care the order, just use `gdebi` and install missing dependency] from <https://mirrors4.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu/dists/bionic/pool/stable/amd64/>
