---
title: proxy加V2Ray加SSL有备而来，Chrome却教我讲武德，不要再犯这样的小聪明
author: Zhuoer Dong
date: '2020-12-12'
slug: proxy加v2ray加ssl有备而来-chrome却教我讲武德-不要再犯这样的小聪明
categories:
  - '2020'
tags: []
authors: []
---



上次使用 V2Ray 的 `RoutingObject` 实现了多台电脑统一用 `research.com` 来访问 Ubuntu 的本地网站之后，野心不断膨胀，今天藏不住了。一方面想要从整个网站细化到特定网页，一方面想要做到神不知鬼不觉。结果被 Chrome 终结了，每个网站都要输一次密码实在不能忍。

起因是本地 pytorch 只 mirror 了官网中 `docs/` 这一部分，浏览网页时随便点一个超链接，就会跳转到 pytorch.org（并忍受巨慢网速）。另外被 Travis“强制执行”^[付费版欠了些 credit，没还清之前连免费版都不让用了。]，倒是探索出用 systemd 实现本地定时跑程序，这样的话完全就可以 build 一大波文档网站了（以tidyverse 为首）。更进一步想到 `pytorch.org/ecosystem` 访问原始网站，`pytorch.org/docs/stable` 则使用本地网站，而让浏览器完全不知情。

有很多因素要考虑，config 比 GUI（如 SwitchOmega）更容易维护，尤其是 V2Ray 免去了设置多台电脑的烦恼。

V2Ray 的 routing 机制可以把一个 inbound 映射到多个 outbound，直连、科学上网和域名替换 ^[也就是 port 与网站之间的关系保存在 V2Ray 中，不需要专门做 mirror 的 `index.html` 了。] 都能实现 。这样一个 http proxy 就够了，理论上可以免去 SwitchOmega（设置 system-wide proxy），但还是只应用到 Chrome 更好。

只有 `attrs['path']` 才能精细到特定网页，但探索一番也没找到好法子来 print `path` 的值，凑合着用吧，`"attrs": "attrs['path'].count('/docs/') == 1"` 完美解决。

但 Chrome 不乐意了，必须添加 SSL 证书才能访问，而且每个子域名都要单独的 ^[`-subj '/CN=localhost'` 把 `localhost` 改为 `www.dongzhuoer.com`。]，每次添加还得输密码 ^[`openssl pkcs12 -export -inkey server.key -in server.crt -out server.p12 -password pass:123456` </br> 然后 Chrome import 时输入 `123456`。]。是可忍孰不可忍！！后来发现 iMac 更过分，SSL 证书归系统管，连 import 的机会都没有。

2021-02-08 后记：当时还发生了其它事，如路由器端口转发闹罢工。。。最后屈服于 Requestly extension 了，能同步 rule 还是挺不错的（虽然 <= 75 个）。
