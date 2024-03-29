---
title: aria2c backend + MySQL driver 就花了一小时，整理果然好耗功夫
date: '2019-02-23'
slug: aria2-backend-mysql-driver-take-1h
categories: 2019
tags: []
authors: []
---



# Beginning

下午学完 Python 之后就把电脑背会了宿舍，周末就“在家办公”喽。

晚上想先把 to do 整一下，就拿 (1)MySQL Python driver 安装教程和 (2) systemctl aria2c backend 开刀。


# Development

- MySQL Python driver 主要是想把 Head First Python 的内容添加到 localsite。
- aria2c JSON RPC 的好处有优秀的浏览器插件：与浏览器高度整合，GUI 管理界面。


aria2c 之前在 Windows 上弄好了，其实 Ubuntu 更简单，有 systemctl 帮忙管理（Windows 还没做到自动化，都是用 VSCode 的 integrated terminal）。

driver 要下载文件（正好先在 terminal 测试一下 aria2c），但 x86 64bit 和 architecture indenpendent 又让我纠结了。

然后又开始维护之前写的 `systemctl-status`，研究怎么把信息显示得即全面又简洁：控制 `systemctl status` 少输出点，`grep -v` 又把绿色弄没了，甚至开始鼓捣怎么用 pipe 去掉最后一行。

哎，我感觉不同任务之间又要开始相互纠缠了。


# Climax

还好这次时间很充足（晚上的工作才刚开始），一个一个慢慢来：

- driver 的文件都下下来，前者是两个 `.so` , 后者是一堆 `.py`，编译好的动态库肯定秒杀一切 script language 啊。
- 找到了 systemctl 的几个参数，把最简单的输出放后面，啰嗦的放前面（需要检查细节时再向上滑）。
- aria2c 写好之后各种测试，url，magnet, torrent 都没问题。


# Epilogue

结果鼓捣一小时，就干这两件小事（然后写这篇 post 又花了 20 min）。


# Afterword

之后不想看书，索性继续解决 to do。下一个是写 pkgdown 的 vignette 不能支持 Rcpp 的 issue。然而在准备 repexp 的时候突然发现没有任何问题，倒是转移到 Rd 里面的 C++ chunk 有个地方写错了，当时可能真是我的 Rcpp 代码有问题把。然后就把 Rcppzhuoer 的文档全部变成 vignette 中的 Rcpp chunk 了。
