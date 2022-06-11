---
title: Docker with GUI, using seafile as an example
author: Zhuoer Dong
date: '2019-01-21'
slug: docker-with-gui-using-seafile-as-an-example
categories: 2019
tags: []
authors: []
---

Seafile 是一个很好用的云盘，尤其是清华提供的 100G 空间，速度不知道甩某度几条街。可惜 Linux 客户端不够友好，在 Ubuntu 上某个系统依赖有问题。我鼓捣了好久，最终放弃了，转而依靠我配置的双系统 ^[给 Windows 留口饭吃]。

-------------------------

但是，debug 时学会了一项很有用的技术，在 Docker 中使用 GUI 程序：

```bash
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix dongzhuoer/seafile
```

Thanks to this [post](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)

-------------------------


附当时用到的 `Dockerfile`

```dockerfile
FROM dongzhuoer/ubuntu-cn:rolling

LABEL maintainer="Zhuoer Dong <dongzhuoer@mail.nankai.edu.cn>"

RUN apt update && apt -y install software-properties-common \
 && add-apt-repository ppa:seafile/seafile-client \
 && apt -y purge software-properties-common && apt -y autoremove && rm -r /var/lib/apt/lists/

RUN apt update && apt -y install seafile-gui && rm -r /var/lib/apt/lists/

RUN useradd zhuoer -m -s /bin/bash

USER zhuoer
ENV HOME /home/zhuoer
CMD /usr/bin/seafile-applet
```

