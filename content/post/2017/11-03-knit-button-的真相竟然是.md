---
title: Knit button 的真相竟然是
date: '2017-11-03'
slug: knit-button-的真相竟然是
categories: 2017
tags: []
authors: []
---



> 那会儿总觉得如果一个 GUI 命令背后的代码不清楚，用起来就会担惊受怕。

RStudio 有一个很方便的 `Knit` 按钮，为了可重复性研究，我就挖了一下其背后的秘密。

其实无非就是将输入文件名和 `encoding` 传递给了一个 R 函数 （默认应该是 `rmarkdown::render()`），就像下面这个例子所演示的：


```
---
knit: "(function(...) {print(list(...))})"
---
```

then you will get the following output on the `Rmarkdown` panel, 

```
[[1]]
[1] "/path/to/work/RStudio/project/widget/test.Rmd"

$encoding
[1] "UTF-8"
```
