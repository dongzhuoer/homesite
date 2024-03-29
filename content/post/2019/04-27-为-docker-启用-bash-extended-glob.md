---
title: 为 Docker 启用 bash extended glob
date: '2019-04-27'
slug: 为-docker-启用-bash-extended-glob
categories: 2019
tags: []
authors: []
---



相信很多第一次用 Docker 的人都会和我一样，忍不住 `docker run --rm ubuntu ls /lib/*/*so`，然后对错误提示感到莫名其妙和彻底失望。

后来我写自己的 Ubuntu image 时，觉得这是 Bash option 没启用的原因，于是
```dockerfile
# enable wildcard & extended glob: http://mywiki.wooledge.org/glob#extglob
RUN sed -E 's/(# If not running interactively)/shopt -s extglob\n\n\1/' -i /etc/bash.bashrc
```

今天想完善一下这个 image，回过头来发现是我理解错了。`*` is interepted by Bash, `ls /lib/*` would expand `*` in the host, then ask docker to `ls` these files。正确地写法应该是 `docker run --rm ubuntu bash -c 'ls /lib/*/*so'`。

同时我还发现了另一件事，`/etc/bash.bashrc` 对 non interactive shell 无效，我试了各种方法都不能 `docker run --rm ubuntu bash -c "ls /usr/lib/x86_+([0-9])-* -d` (只有加上 `-i` 才能 work)。最后我意识到 Docker image 的 non interactive shell 不可能设置 option，因为它完全是从零开始的，而一般我们使用的 terminal 归根结底还是从 tty7 或 ssh 等来的（才能进行各种配置）。
