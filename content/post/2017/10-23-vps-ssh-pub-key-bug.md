---
title: VPS SSH 公钥之巨坑
date: '2017-10-23'
slug: vps-ssh-pub-key-bug
categories: 2017
tags: []
authors: []
---



> 当时在用 Digtal Ocean's VPS 翻墙。不记得这次具体发生什么了，应该是在创建 VPS 时添加了 SSH 公钥。本以为这样就可以直接登陆，不用费心改密码、`ssh-copy-id`之类的；结果倒好，压根登录不了，简直是完全无法控制。


Epilogue
# Preface

以后还是手动输密码的好，好歹能从 terminal 登进去， 不然出了错就只能查必应（对，连 Google 都没有）



# Beginning

这次的问题是

```bash
$ ssh root@165.227.**.***
Connection closed by 165.227.**.*** port 22
```



# Development

On Digtal Ocean, `Reset root password`, then `Launch Console`. 

`systemctl status sshd`
```
Oct 16 08:59:45 openstack sshd[1214]: error: Could not load host key: /etc/ssh/ss
Oct 16 08:59:45 openstack sshd[1214]: error: Could not load host key: /etc/ssh/ss
Oct 16 08:59:45 openstack sshd[1214]: error: Could not load host key: /etc/ssh/ss
```

Although ssh doesn't fail (it should fail and very, very, very _loudly_), you can't log in. 



# Climax

Thanks for https://linux.cn/article-4226-1.html

```bash
sudo dpkg-reconfigure openssh-server 
# choose 'install the package maintainer's version' 
sudo systemctl restart sshd
```



# Epilogue

Wa, VPS is really a fantastic tool to waste time!



# Afterword

Then `vda1` only has 2G, you must be kidding!

Fortunately, it isn't a really hard problem, although the solution isn't easy anyway.

```bash
sudo parted /dev/vda
# resizepart
# 1
# 20G
sudo partprobe
sudo resize2fs /dev/vda1
```
