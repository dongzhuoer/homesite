---
title: finally, apt doesn't waste my time
date: '2018-03-11'
slug: apt-ipv4
categories: 2018
tags: []
authors: []
---



# Preface

人在天朝，身不由己。何以解忧，唯有镜像。 


# Beginning

The problem of apt has trouble me for a long time. 我曾为此换到阿里云的镜像，但是不如清华的快。


# Development
 
Several weeks earlier, I found the problem root from ipv6：`mirrors.tuna.tsinghua.edu.cn` 是自动解析，可能清华的镜像发现我是校园网，就以为我有 ipv6, 然而我并没有（此处鄙视南开校园网），所以就等、等、等 [^ipv6-fail]，直到超时。

So the solution is to use `mirrors4.tuna.tsinghua.edu.cn` instead of `mirrors.tuna.tsinghua.edu.cn` when you can not connect to IPv6 (Especially inside NKU_WLAN):

`sudo sed --in-place=.bak 's/mirrors\.tuna/mirrors4.tuna/' /etc/apt/sources.list`


# Climax

Then I get into trouble when I handle docker mirror. That lead me to find a [better solution](https://www.vultr.com/docs/force-apt-get-to-ipv4-or-ipv6-on-ubuntu-or-debian):

`sudo apt -o Acquire::ForceIPv4=true ...`

By the way, I successfully add deb repository for VSCode, slack, chrome, skype, sogoupinyin. Though it took me 2 hours and more, I thought update software automatically would benefit me a lot.


# Epilogue

I think now I should have sloved the problem completely.








[^ipv6-fail]: 

    ```
    0% [Connecting to mirrors.tuna.tsinghua.edu.cn (2402:f000:1:416:101:6:6:178)] 
    ```
    ```
    Ign:6 https://mirrors.tuna.tsinghua.edu.cn/CRAN/bin/linux/ubuntu artful/ InRelease
    ```
