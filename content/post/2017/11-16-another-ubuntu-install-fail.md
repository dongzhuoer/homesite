---
title: 又一次失败的 Ubuntu 安装
date: '2017-11-16'
slug: another-ubuntu-install-fail
categories: 2017
tags: []
authors: []
---



安装 Ubuntu 果然是一件很刺激的事，装好之后的“立即重启”就像一扇神奇的传送门，有时通往天堂，有时通往地狱。

这回是师姐的 Ubuntu，不过再过几天就要给我用了，可不能懈怠。

这一次又失败了，以至于我重装了两次，后来发现还是主板的问题。具体是要在 BIOS 的 **StartUp** 中, 把 `CSM` (Compatibility Support Module) 设置为 `Disabled`。因为它的作用是支持非UEFI的旧系统，而我装的必须是 UEFI 的啊。

看来 BIOS 还得好好研究啊，真希望有一本权威而详实的书啊，不过这个至少还是比上次的 Windows Server _2003_ 强多了。
