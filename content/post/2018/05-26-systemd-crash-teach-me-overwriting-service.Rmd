---
title: a lucky systemd crash teach me how to overwrite systemd service in a elegant way
author: Zhuoer Dong
date: '2018-05-26'
slug: systemd-crash-teach-me-overwriting-service
categories: 2018
tags: []
authors: []
---

Suddenly, systemd broken, even `systemctl-status` reports error. So I restart Ubuntu, and the situation become even worse: I can't see the desktop. Luckily, after another restart, everything becomes fine.

There seems to be something wrong with Docker's systemd. This accident gives me a chance to find a [elegant way](http://www.jinbuguo.com/systemd/systemd.unit.html#) to overwrite default `.service`：

> 对于例如 foo.service 这样的单元文件， 可以同时存在对应的 foo.service.d/ 目录， 当解析完主单元文件之后，目录中所有以 ".conf" 结尾的文件， 都会被按照文件名的字典顺序，依次解析(相当于依次附加到主单元文件的末尾)。 这样就可以方便的修改单元的设置，或者为单元添加额外的设置，而无需修改单元文件本身。

`/lib/systemd/system/docker.service.d/registry-mirror.conf`
```
[Service]
ExecStart=  # reset the option in /lib/systemd/system/docker.service
ExecStart=/usr/bin/dockerd -H fd:// --registry-mirror=https://registry.docker-cn.com
```

非常感谢金步国。从这次经历中我体会到有些中文教程也是很好的，一味强调英文可能在无形中成了装逼。

2019-03-01 后记：后来清华的校园网比较给力，官方的 registry 网速也还可以，也就用不着修改 `docker.service` 了。






