---
title: 帮师姐装 BEAST2 add-on，官方文档也会出错
date: '2018-01-01'
slug: 帮师姐装-beast2-add-on-官方文档也会出错
categories: 2018
tags: []
authors: []
---



由于系统原因，我给谢老师的工作站装了新的 CentOS。虽然原来的文件都还能访问，但有些在 `/home` 的软件就得重新装，比如燕卓师姐的 BEAST2 add-on。

这里我主要想吐槽 [offical documentation](https://www.beast2.org/managing-packages/) 居然有错误!

```
for Linux /home/<YourName>/.beast/2.X/VSS
```

should be 

```
for Linux /home/<YourName>/.beast/2.X
```


顺便记一下师姐用到的版本号（好像用的是昊阳师兄写好的输入文件格式，新版本不兼容）：

- beast 2.4.1 (openjdk-8)
  - BDSKY 1.3.1
  - BEAST 2.4.4
  - BEASTLabs 1.5.2
  - MODEL_SELECTION 1.3.1
