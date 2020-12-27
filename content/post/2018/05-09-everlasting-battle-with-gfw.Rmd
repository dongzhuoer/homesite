---
title: everlasting battle with GFW
author: Zhuoer Dong
date: '2018-05-09'
slug: everlasting-battle-with-gfw
categories: 2018
tags: []
authors: []
---

> 与 GFW 的战斗永不停息，下面是以前写的几篇 post。

# 2017-12-06  meet long-lost google scholar

A few days ago, I found I can't access Google Scholar, but I was to busy to deal with it.

Now, I need to search papers about de novo RNA-seq assembly. So I feel urgent to use it. I search Google, and find many people talks about host, ipv6, etc. Not believed what they say, I decided to have a try:

`vim /etc/hosts` ^[execute `host google.com` on VPS to get the ipv6 address]
```
# Google Scholar 
2607:f8b0:4005:801::200e scholar.google.cn
2607:f8b0:4005:801::200e scholar.google.com.hk
2607:f8b0:4005:801::200e scholar.google.com
2607:f8b0:4005:801::200e scholar.l.google.com
```

It turns out the method works! Now I can happily use Google Scholar again, although changing host periodically may be cumbersome. 

Thank Google, as long as I can access you, there is still a help.



# 2018-05-01 Google resources reverse proxy

copied from [here](https://fengmk2.com/blog/2016/google-fonts-mirror)

- https://ajax.googleapis.com => https://ajax.googleapis.cnpmjs.org
- https://fonts.googleapis.com => https://fonts.googleapis.cnpmjs.org
- https://fonts.gstatic.com => https://fonts.gstatic.cnpmjs.org
- https://themes.googleusercontent.com => https://themes.googleusercontent.cnpmjs.org

A few days later (2018-05-09), https://fonts.googleapis.cnpmjs.org caused a big trouble to me. A font didn't exist on [it](https://fonts.googleapis.cnpmjs.org/css?family=Merriweather:300,300i,400,700,700i&subset=cyrillic,cyrillic-ext,latin-ext), but did on [Google](https://fonts.googleapis.com/css?family=Merriweather:300,300i,400,700,700i&subset=cyrillic,cyrillic-ext,latin-ext). 

I realized that the biggest problem with GFW is that it's very hard, or better, impossible to find a universal solution. Shadowsocks may fail at times, reverse proxy may lag in synchronize, block may impair things I really need.

At least for now, Google Fonts has been completely blocked in my heart, following Google Analytics and Tag Manager.


