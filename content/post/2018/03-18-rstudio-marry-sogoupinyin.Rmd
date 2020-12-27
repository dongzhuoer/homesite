---
title: RStudio marry 搜狗拼音输入法
author: Zhuoer Dong
date: '2018-03-18'
slug: rstudio-marry-sogoupinyin
categories: 2018
tags: []
authors: []
---


> From above 1.2.5001, one can just try the first method in [Development](#Development), the only flaw is the square when you type Pinyin.



# Begining

Ubuntu 不愧是 Linux 的亲儿子 ^[我瞎说的]，连搜狗拼音输入法都有得用。

但一件很尴尬的事情是，我最喜欢的 IDE，RStudio，不支持搜狗拼音输入法。我曾在爆栈网 ^[Stack Overflow] 搜过一次，结果最好的结局方法貌似是 用 RStudio Server 来代替 ^[毕竟浏览器可以正常使用搜狗拼音输入法]，真让人无语。

But today, I manage to use 搜狗拼音输入法 in RStudio, after exploring for half a day.


# Development

Thanks to this [post](https://support.rstudio.com/hc/en-us/articles/205605748-Using-RStudio-0-99-with-Fctix-on-Linux), I know the reason is that `libfcitxplatforminputcontextplugin.so` is missing. I use `apt-file find` and find `fcitx-frontend-qt5` provides that `.so`. But 搜狗拼音输入法 still doesn't work.

Then I found another [post](https://my.oschina.net/lieefu/blog/505363?p=2), which helped me build [fcitx-qt5](https://github.com/fcitx/fcitx-qt5) from source: 

```
sudo apt install cmake extra-cmake-modules fcitx-libs-dev
# the critical step, you have to install Qt
export PATH="/path/to/Qt/5.10.1/gcc_64/bin:$PATH"
```

After that, I get a `libfcitxplatforminputcontextplugin.so`, and this `.so` did help enabled 搜狗拼音输入法 in Qt Creator.


# Climax

Motivated by aboving result, I figured out that RStudio 1.1.142 use Qt 5.4.2. 

Finally, I built `libfcitxplatforminputcontextplugin.so` using Qt 5.4.2 and fixed the problem ^[put it inside `/usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/`].

By the way, the Qt Maintenance Tool is really clumsy, you'd better uninstall & install if you want to add modules.


# Epilogue

写于 2019-02-28：可惜我没有把详细过程记下来，后来我一直用着编译好的 `.so`，到目前为止都没什么问题。等到以后版本不兼容的时候，重新 build 估计又要花一些时间。









