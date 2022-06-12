---
title: knitr 又不听话了，自动生成 _files/ 这能忍？
date: '2019-04-01'
slug: knitr-naughty-_files
categories: 2019
tags: []
authors: []
---



这几天在整理 thesis 的几个 repo，把生成图片的代码做成可以 run 的 `.Rmd` 自然不必说。

昨天还好好的，今天突然冒出来一个 `***_files/`，打开看一下，基本都是垃圾，

```
├── [   0]  fonts
│   ├── [ 20K]  open-sans-400.woff
│   └── [ 21K]  open-sans-700.woff
├── [   0]  images
│   ├── [3.1K]  body-bg.jpg
│   ├── [8.7K]  body-bg.png
│   ├── [ 10K]  header-bg.jpg
│   └── [ 33K]  highlight-bg.jpg
└── [3.7K]  style.css
```

I guess there are some problems with `prettydoc::html_pretty`, so I change to `html_document: default`, but it also produces the folder (although empty). 

Then I try CRAN version of knitr & rmakrdown, which doesn't help.

Later, I try to add `rm -r ***_files/` in `tasks.json`. Work as it does, I don't feel it's the appropriate way.

To beat a dead horese, I ramble on other repos [^1]. Suddenly I find `lulab-rotation-summary` doesen't have the problem. Looking at the `.Rmd` code for a while, the reason seems to be customing `fig.path`.

[^1]: 这里是为了英文写起来更方便，实际上我一开始就开始看其它 repo 了，后面甚至把好多 repo 的 `tasks.json` 都改了。得出新方法后又都改回来，换上新方法。哇哈哈哈，时间就是这么被浪费的。

Finally I find a solution:

```r
knitr::opts_chunk$set(fig.path = '/tmp/') # prevent trash `_files/`, not know why
```

I admit it's not perfact, but I can't think up a better one at the moment.
