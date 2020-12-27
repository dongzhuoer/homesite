---
title: failed attempt to build Gogs
author: Zhuoer Dong
date: '2018-01-06'
slug: gogs-failed
categories: 2018
tags: []
authors: []
---

> 当时对代码的保存总是不放心


Though I get a stable IP by ssh reverse tunnel on Xie's workstation and can use Git through LAN instead of GitHub, I still feel dissatisfy. So I turned to self-hosted Git service, Gogs.

After wasting a afternoon, I failed, mainly due to non-default port, especially ssh.

There is no space to specify custom port in Git protocol (maybe due to scp), so I switch to ssh protocol. Then I get `ssh://git@domain.com:port/user/repo.git`, which obviously doesn't work. I was not only asked to type password for Git ^[although I have add SSH key for my account], but also told `/user/repo.git` doesn't seem like a Git repository even after I did.

Finally, I figured out the url should be `ssh://git@domain.com:porthome/git/gogs-repositories/user/repo.git`, and managed to push ^[still need to type password of Git]. But, Gogs tells me that the repository is empty.

Desperated, I want to go VPS for a demo. But GFW seems to have detected my proxy ^[The alternative hopenthesis is either Nankai's or DO's network is too slow, I would rather believe it's the former], maybe I should change for another VPS. 

Following is the code I used:

```bash
sudo useradd git -m -s /bin/bash
sudo apt install mysql-server -y

mysql -u root -ppasswprd
mysql>CREATE DATABASE gogs;

mkdir -p custom/conf
```

`custom/conf/app.ini`, note password for mysql.

