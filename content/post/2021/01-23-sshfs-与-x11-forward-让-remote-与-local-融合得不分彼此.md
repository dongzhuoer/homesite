---
title: sshfs 与 X11 forward 让 remote 与 local 融合得不分彼此
date: '2021-01-23'
slug: sshfs-与-x11-forward-让-remote-与-local-融合得不分彼此
categories:
  - '2021'
tags: []
authors: []
---



之前配置的 sshfs 真是好东西，尤其是 `/home/dongzhuoer` 的小 trick，两者用到的 path 一模一样。GPU10 上 cryoSPARC 中数据的path 复制到 Dell Ubuntu 后直接就可以用，简直不要太爽。

可惜后来改用 Matebook Windows 办公（Dell 主要作为后端），就没有那么方便了。

一种思路是用 ssh X11 forward 直接运行 Dell 上的程序，查了很多教程，都没用。原来并不是“一行代码”那么简单，必须得 [装一个 X server](https://jdhao.github.io/2018/03/02/Windows-connect-server-x11-with-gitbash/)。启动 VcXsrv ，用 Git-bash 在 `~/.bashrc` 中加入 `export DISPLAY=localhost:0.0`，然后就只剩一行代码了。xclock 测试可行，ChimeraX 慢死了。在 Dell 上跑 X11 forward 也很慢，证明不是网速的问题，就先搁置了。

换用另一种思路，直接把 https://github.com/billziss-gh/sshfs-win 移植到 Windows。配置比较麻烦，故技重施，但 symbol link 不好使。倒是 Git-bash 输入 `/d/` 也不麻烦（`D://` 丑死了），体验挺棒的（之前还需要把数据 scp 到本地再打开）。后来暴露出经常断开的问题，需要在文件管理器点一下图标才会重连；更烦人的是，断开后打开 `.iso` 会分配 `D` 盘符，可读，但是无法弹出，唯有重启。

一段时间后，前一种思路也有些用途，比如 firefox （虽慢）可以做很多事，控制光纤路由器，调试 proxy 等。但 Chrome 不听话（其实把已有的 Chrome 杀掉之后就可以用了）。
