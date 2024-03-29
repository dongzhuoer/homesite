---
title: 又造了一个小轮子：`ggtree::theme_tree2()`
date: '2017-11-09'
slug: theme-tree2
categories: 2017
tags: []
authors: []
---



> 后来演变成 **ggcsgb** 包，还帮小雅师姐的论文作图。

当年在谢强老师实验室的时候，老师推荐我写一个把进化树画到地质年代图上的小程序。

因为我要在树的下层加年代图，所以背景得改成透明的，但 x 轴又不想丢，于是就开始研究各种 `theme` 的黑魔法了，慢慢地就挖出了下面的代码：

```r
theme_grey() %+replace%
		theme(panel.grid.minor = element_blank(), panel.grid.major = element_blank(),
			  panel.border = element_blank(), axis.line.y = element_blank(),
			  axis.ticks.y = element_blank(), axis.text.y = element_blank())
```


然而纯属浪费时间：

 1. `ggimage::theme_transparent()` 早就写好了
 1. `theme` 是可以随便加的，根本不需要 `%+replace%` 这种看起来很厉害其实并无卵用的东西

当时应该是在 `ggtree::theme_tree()` 的基础上加 `theme` 时总是有些地方改不到位，然后就一朝被蛇咬、十年怕井绳了。

不过 `theme()` 这个事也确实有上山容易下山难的情况。比如 `theme1 = theme(...)`，前人一开心加了个 `theme2 = theme1 + theme(axis.text.x = element_blank())` 之后，你就很难从 `theme2` 再改回到 `theme1`。
