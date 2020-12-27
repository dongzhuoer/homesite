---
title: Bye PyCharm, Hello Spyder
author: Zhuoer Dong
date: '2019-11-05'
slug: bye-pycharm-hello-spyder
categories: 2019
tags: []
authors: []
---



# Preface

我迟迟没掌握 Python 的一个原因就是没有好用的 IDE（主要原因是我的 R 已经~~炉火纯青~~勉强够用了）。Wing 沉迷于找破解码（Python2 和 Python3 我都有），PyCharm 则执着于比较 Professional（南开邮箱可以申请教育许可证）和 Community 的区别，以及方便的安装方式（一度觉得 Snap 不错，除了网速慢），直到 VSCode 横空出世、统一了所有语言（我用它开发过 R，C++ 和 Python）。

Python 最麻烦的是用换行和缩进来划分层次，这意味着不能方便地把代码送到 terminal 去执行（R 和 Bash 都是上有 source file、下有 terminal，）。我初学 Python 时就急切地想知道怎样把 Python 代码塞到一行，结果当然是弃疗了，后来 IPython 的 `paste` magic 部分解决了这一问题。



# Begining

昨天 `df -h` 时觉得 Snap 的 `dev/sloop` 很烦人，PyCharm 也不常用（被 VSCode 碾压），就不死心的再筛了一遍 Python 的 IDE。看来我的看法被 VSCode 影响了不少 ^[ 2019 年 11 月 06 号注：换用 Dell Micro 之后发现 VSCode 其实并不轻量，尤其是 Python 支持，占用很多内存，把我的  Ubuntu 卡得不行。]，以前看着丑陋不堪的，现在觉得很简洁轻量 。一番比较之后，Spyder 脱颖而出，以后~~就跟你混了~~你就是我的小弟了。



# Development

当时就狂热地鼓捣了一番，冷静下来之后专心搬砖。今天更是一大早就开始鼓捣，上午几乎都搭进去了，下午也占用科研时间解决了搜狗输入法的问题，然后就基本可以投入使用了。

`run selection` 这一快捷键完美地实现了我的需求，可惜 `Ctrl+Enter` 已经被别的占用了，最坑的是不能 disable。我只能先将其打发到不用的地方（`Alt` + 数字），然后再绑定上。



# Climax

这里主要谈谈搜狗输入法的问题。

`apt` 安装的 Spyder 还是好好的，在 venv 中 `pip` 安装 ^[我为科研项目创建了一个 venv，在里面安装 Spyder 的好处是不需要设置 Python 路径，默认的 same as Spyder's 就够用了。] 的就不能用搜狗输入法了。本质上是不支持 fcitx，放狗一搜，果还是 Qt 的锅（和 RStudio 一样），但只能找到 Conda 的解决方案。我翻遍了 venv 中 `lib/python3.7/site-packages/spyder/` 都没有找到 `platforminputcontexts/`。

这时就该请出控制变量法了，先看看系统的 `pip` 会怎样，但 site library 已经有了 `spyder` package，只能先（用 `apt`）卸载掉, 再装到 user library 。居然可以用搜狗输入法，那么差别在哪呢？

我先把 user library 清理掉，装回 site library 的。`pip` 列出了一起安装的 package，我就一个一个地卸，`PyQt5` 引起了我的注意，估计就躲在这。赶紧用 `find` 搜索整个 venv 文件夹，果然被给我揪出来了，`lib/python3.7/site-packages/PyQt5/Qt/plugins/platforminputcontexts/`。



# Epilogue

后面的事就很简单了，和 RStudio 一样，安装 `fcitx-frontend-qt5`， 把 `libfcitxplatforminputcontextplugin.so` 拷贝过去就好了。



# Afterword

后来想过直接把 spyder 装到 user library，这样更新更快。但是没有 desktop 图标，还是算了吧。
