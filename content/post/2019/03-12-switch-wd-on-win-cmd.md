---
title: switch working directory on Windows command line
date: '2019-03-12'
slug: switch-wd-on-win-cmd
categories: 2019
tags: []
authors: []
---



以前 Windows 和 Ubuntu 两条腿走路的时候，觉得 `cmd` 比起 `bash` 最大的缺点就是不能设置 working directory，只能通过以下两种方式迂回：

- 文件浏览器浏览到指定目录再打开 cmd 或者
- 用 VSCode 打开指定目录再用 integrated terminal 

后来找到了一篇 [博客](https://blogs.msdn.microsoft.com/oldnewthing/20101011-00/?p=12563/)，原来是一个历史遗留问题 （真是辛苦当时的程序员了） 。 

简单来说，解决方案如下：

```
C:\Users\Allan>cd /D W:\work

W:\work>
```

or

```
C:\Users\Allan>W:

W:\>cd work

W:\work>
```
