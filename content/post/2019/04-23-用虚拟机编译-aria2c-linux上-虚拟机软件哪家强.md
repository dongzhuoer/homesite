---
title: 用虚拟机编译 aria2c —— （Linux上）虚拟机软件哪家强？
date: '2019-04-23'
slug: 用虚拟机编译-aria2c-linux上-虚拟机软件哪家强
categories: 2019
tags: []
authors: []
---



> 这是我刚进实验室的事了，那时 single-cell 已经有人了，于是我就去做 isSHAPE database 。那么大的 `.fasta.gz` 文件，当然是用 aria2c 来下载才爽啊，可惜集群安装不了，binary 也不行（缺 `**ssl**.so`）。我就琢磨着 `build` 一个 standalone 的（`--static-link`）



# Virtual box

首先找到相应的版本，[CentOS 6.6 iso](https://mirror.nsc.liu.se/centos-store/6.6/isos/x86_64/)，装好后无法开机。

于是搜到这个 [解决办法](https://blog.csdn.net/qq_21397217/article/details/52396861)，其实没能彻底解决，算是个提示吧。居然可以输入 `\EFI\redhat\grub.efi` 来开机，boot 也没有那么神秘嘛。

Virtual box 最烦的是不支持 mouse integration，鼠标要么就被虚拟机捕获（得按 Right Ctrl 才能出来），要么就只能操作主机。最终我还是决定去装 VMware Workstation。


# VMware Workstation 14

当然使用最新版（15），但是一直安装失败，弹窗让我看 log 但又不给出文件路径。

换成 14 ，能安装但启动失败，不过列出了 log 文件路径。`vmmon` 和 `vmnet` 编译错误，看了一下，是源代码的问题，我无能为力。

后来发现在 GitHub 上有人提供了 patch：首先在 [这里](https://github.com/mkubecek/vmware-host-modules/releases) 找到对应版本，然后，

```bash
make 
sudo make install
```



## VMware Workstation 15

14 可以用之后，我还是想装 15。把前者卸了之后，后者突然就能装了。

启动依然会失败，不过我们有 patch。创建好一个虚拟机，开机又报错，

```
Please make sure that the kernel module `vmmon' is loaded
```

还好解决并不难

```bash
sudo systemctl restart vmware
```
