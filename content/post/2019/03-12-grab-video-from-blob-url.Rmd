---
title: grab video from blob url
author: Zhuoer Dong
date: '2019-03-12'
slug: grab-video-from-blob-url
categories: 2019
tags: []
authors: []
---


自从 iGEM 时自学了网页编程，我觉得 HTML5 的 `<video>` 标签最大的好处就是可以很方便地 download 视频 ^[一脸坏笑，我当时还写脚本来批量 download 某付费网站的视频。]。

可惜后来有了 `src="blob:http://***"`，就很难找到视频的真实 url 了。

后来在鲁志老师实验室轮转时，JC 的一篇文献做了一个 [video abstract](https://www.nejm.org/doi/full/10.1056/NEJMra1704286)。鲁老师想把它下载下来，于是我就试了一下，没想到还真成了 ^[我觉得该案例有特殊性，应该不是所有的 `blob` 都能这么下载]。

当时没时间写下具体步骤，故这里只能列一下两个很有用的答案：

- https://stackoverflow.com/questions/42901942/how-do-we-download-a-blob-url-video#answer-49835269 
- https://superuser.com/questions/1260846/downloading-m3u8-videos

