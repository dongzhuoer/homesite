---
title: 永别了，Windows
author: Zhuoer Dong
date: '2018-01-25'
slug: windows-bye
categories: 2018
tags: []
authors: []
---

> 以前 Windows 还是我办公的得力助手，现在已经彻底沦为娱乐用途了。



# R


- On Windows, `.Renviron` only works for RStudio, so I add `R_LIBS_USER` to PATH rather than `.Renviron`.
- Rtools  
  1. `R-x.y.z/etc/x64/Makeconf` line 19:  `/path/to/Rtools/mingw_64/bin/`
  1.  edit PATH



# Visual Studio 笔记

> Visual Studio 带我进入了编程的世界，可惜这么庞大的东西终究不合我的口味（最后一次用是在陆剑老师那，编种群遗传模拟时）。

1. You must choose a SDK for compiling C++ (even console application)
1. Linux tool is of no use, it just connect to a remote server
1. set CTRL+W to closing tab
    1. `Tools` => `Options` => `Keyboard...`
    1. Add CTRL+W as a Global shortcut for `Window.CloseDocumentWindow`
    1. Remove the CTRL+W shortcut for `Edit.SelectCurrentWord`



# software 评论 

## compress

  + 360zip
    1. 最新版不支持压缩 `.rar`，但保存了支持 `.rar` 的旧版
    1. 自动更新 
  
  + 2345好压
    1. null
    1. 不支持 `.rar`

  + 快压
    1. null
    1. 不支持 `.rar`，安装前捆绑
  
  + WinRAR
    1. 中文版在中国完全免费
    1. 启动时弹窗广告，英文版仅试用


## office

  + WPS Office
    1. 轻量级全平台，已经纯净化 ^[启动时偶尔会要求登陆，选择“暂不登陆”即可]
    1. 某些功能不足，Linux 更新较慢

  + Microsoft Office
    1. 成熟、标准、强大
    1. 超庞大

  + SumatraPDF
    1. 轻量级 PDF 阅读器，启动超快，方便易用，支持多种文件类型
    1. null

  + 福昕PDF编辑器
    1. PDF 神器，全面支持各种编辑和转化
    1. 对其他文件格式支持不够

  + UltraEdit
    1. 50% less memory usage and 33% less time spent than `vim`, patched for Windows ^[don't **Patch Host File** in `crack.exe`, as which may result in trojan (mild, but recur after reboot)]
    1. not perform well for very large file (16GB)

  + Notepad++
    1. 免费
    1. 仅 Windows


## IDE

  + RStudio
    1. 全能 R IDE，媲美 Visual Studio ，尤其是代码提示
    1. 撤销有时有点问题，没有树形文件浏览器

  + Visual Studio
    1. ultimate C++ IDE, HTML、Javascript、CSS 源代码编辑
    1. 更新慢，特庞大

  + Visual Studio Code
    1. 在文件夹中查找和替换，树形浏览文件夹，可在任意子文件夹打开 cmd
    1. 启动较慢
    
  + texlive
    1. 已便携化，清华镜像，只需添加到 PATH
    1. null

  + Android Studio
    1. Android 官方出品，自带 SDK
    2. 不过好像还需要联网下载, 关键是不知道需不需要翻墙

  + CodeBlocks
    1. 轻量级 C++ IDE，加上 `mingw-w64` 后, 对 C++ 新版本的支持甚至能超过 Ubuntu
    1. null

  + Wing IDE
    1. ultimate python IDE， 已完全破解
    1. null


## media

  + Adobe Photoshop
    1. ultimate image software
    1. 要破解，很庞大

  + Vmware Workstation Pro
    1. ultimate visual machine, mainly for Ubuntu
    1. 占用资源多

  + VLC media player
    1. 轻量纯净，支持多种文件类型
    1. null



# registry

曾经崇尚“纯净”的操作系统，实现方式就是 _定期_ 重装，但手动设置默认应用很麻烦，就希望用注册表来一键完成。

倒腾了几个 repo 之后，终于把 `reg.reg` 弄丢了； 如今也就只剩一些文档（当时查得可费劲了，非常不系统）

- [File Types](https://docs.microsoft.com/en-us/windows/win32/shell/fa-file-types?redirectedfrom=MSDN)
- [Registering Verbs for File Name Extensions](https://docs.microsoft.com/en-us/visualstudio/extensibility/registering-verbs-for-file-name-extensions?view=vs-2015)
- [Special Variables](https://superuser.com/a/473602/764435)

，和一个例子

excute `.cmd`, `.bat`, `.ps1` file when double click  
	
```reg
[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bat\UserChoice]
[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd\UserChoice]
[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1\UserChoice]
```

最后是 `reg.reg` 的目录，看看曾经痴迷的 _绿色_ 软件

1. Context menu (right click in explorer)
    1. cmd
    1. Git-GUI
    1. Git-bash
    1. Notepad++
1. Software
    1. R
    1. Java Development Kit
1. File Types
    1. others
    1. Rstudio
    1. FASTA Sequence
    1. image
    1. media
    1. text
    1. Office
1. Programmatic Identifiers