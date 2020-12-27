---
title: nutshell 重生——不断否定、修改才能让知识真正成为技能
author: Zhuoer Dong
date: '2020-05-05'
slug: nutshell-重生-不断否定-修改才能让知识真正成为技能
categories: 2020
tags: []
authors: []
---



我建立这些 repo 的初心就是方便自己，nutshell——作为文档的集大成者——更应该做好表率。这次彻底翻新，就是要把那些用不到的都清理掉，让 nutshell 真正成为我遇到问题时的好帮手。

把一些是在不忍心删除的放在这里，比如

> In `/etc/passwd`, the 3rd field indicates the number of days (since 1970-01-01) since last password change, empty indicates never and `0` forces user to change.

当初学习的时间觉得“好厉害啊”，但又完全用不上（我又不是管理员）。

怎么只有这一项呢？也许是后来看开了之后都删了吧。

---------------------------------------

privoxy 太长了，就放到最后吧。感谢V2Ray，不需要专门 ^[后来发现 haproxy 切换 proxy 的功能也可以实现，但有时要重新加载网页，还是不如只用一个 proxy 来得方便。] 写程序来 turn socks proxy into http proxy。

`privoxy` is pretty useful when some program can't use socks proxy, but still need to bypass GFW.

`sudo vim /etc/privoxy/shadowsocks.config`
```
user-manual /usr/share/doc/privoxy/user-manual
logfile logfile
listen-address  127.0.0.1:1081
listen-address  [::1]:1081
keep-alive-timeout 5
tolerate-pipelining 1
socket-timeout 300
forward-socks5 / 127.0.0.1:1080 .
```

`sudo vim /etc/systemd/system/privoxy-ss.service`
```
[Unit]
Description=Tranfrom socks5 proxy to http proxy using privoxy
Documentation=man:privoxy(8) 
Documentation=https://www.privoxy.org/user-manual/
After=network.target
Wants=haproxy-ss.service

[Service]
ExecStart=/usr/sbin/privoxy --no-daemon --pidfile /var/run/privoxy-ss.pid --user privoxy /etc/privoxy/shadowsocks.config 
ExecStopPost=/bin/rm -f /var/run/privoxy-ss.pid

[Install]
WantedBy=multi-user.target
```

- `listen-address` can be retricted to the computer's real IP (I have used this feature to temporarily let other people inside NKU LAN break GFW.).
- `forward-socks5 .github.com 127.0.0.1:1080 .` can use shadowsocks only for certain domain and direct connect for others.
