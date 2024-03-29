---
title: shadowsocks return to systemd from Docker
date: '2019-03-27'
slug: shadowsocks-back-systemd
categories: 2019
tags: []
authors: []
---



> 不能上网果然是一件让人非常不爽的事情。

上午看完 Gap 的第一章，想处理一些积攒的 task，其中包括汇报 **knitr** 的一个 [issue](https://github.com/yihui/knitr/issues/1579)。老规矩，代码和 output 的截图都要粘过去，但是图片一直传不上去，我就先听报告（蹭饭）去了。

下午（省略 3h）接着弄，发现 VPS 的 SSH 一直连不上，甚至 GitHub 都无法访问了。算了，破财消灾，开热点。GitHub 好歹可以访问了，VPS 还是连不上，截图依然传不上去。我觉得是因为 GitHub 图片上传的服务提供商需要翻墙才能访问。

想起来到了清华终于可以访问 IPv6 了（昨天刚测试过），就想试一下。先是 SSH，其实不难，`ssh -6 user@ipv6`，成功了。那么让 Shadowsocks 走 IPv6 不就好了吗。

之前为了更方便地重置 VPS，Shadowsocks 被我赶到 Docker 中去了，于是我开始查 Docker 使用 IPv6，以及 IPv6 的通用地址[^0000]（类似于 `0.0.0.0`）。按照 [官方文档](https://docs.docker.com/config/daemon/ipv6/) 操作后，报错了，貌似是要分配一个 IPv6 的路由，饶了我吧；另一边要顺利得多，`::` 即可。

先直接执行 `ssserver` 命令，果然可以用。吃完晚饭回来，想顺便恢复一下谷歌学术[^1]，在 VPS 改 host 就行了。

我开始考虑重新用 Systemd 来管理 Shadowsocks 。自从有了 `dongzhuoer.com` 的域名后，就不用手动维护 IP 地址了；密码也不用太担心，我的 VPS 本身就有密码保护。这样的话，`.service` 文件用一个 `echo` 命令也能创建。至于客户端这边，我发现用普通用户权限也是可以使用的，这甚至比 Docker 还要方便：只用维护`.service` 文件，而不是一长串 `docker` 命令 [^long-command]。

[^0000]: 我之前在 Docker 中用 Shadowsocks 时，还在这一点上花了不少功夫。先说直接用 Shadowsocks 的情况，你可以使用 VPS 的公网 IP，也可以使用 `0.0.0.0`，后者的好处是即使公网 IP 换了配置也一样生效。由于 Docker 涉及一次转发，所以 `0.0.0.0` 方便得多（感觉找到 Docker 的“公网IP”会很麻烦）。
[^1]: 用 Docker 之后就一直不能用了，前段时间蓝灯也不免费了。
[^long-command]: 这里记一下这该死的一长串命令

    ```bash
    # server on VPS
    docker run --name ssserver -d --restart=unless-stopped -p 80:8388 dongzhuoer/shadowsocks ssserver -s 0.0.0.0 -k password
    
    # client on local
    docker run --name sslocal -d --restart=unless-stopped -p 127.0.0.1:1084:1080 dongzhuoer/shadowsocks sslocal -s vps4.dongzhuoer.com -p 80 -k password -b 0.0.0.0
    ```

    `dongzhuoer/shadowsocks` 的 image 其实很简单，`apt install shadowsocks` 就行了。（实际上我还开启了 TCP fast open，但感觉不重要，说实话我到现在都不明白具体有哪些提升。）
    
    我还用过 `--add-host scholar.google.com:2607:f8b0:4005:808::2004` 来访问谷歌学术，但没成功。现在看来可能是因为我加在了 client 而不是 server 上，无论如何，现在 VPS 的 IPv4 不能访问，也就无从验证了。
